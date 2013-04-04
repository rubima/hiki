#!/usr/bin/env ruby

$LOAD_PATH.unshift '.'

require 'hiki/app'
require 'hiki/attachment'
require 'webrick/httpauth/htpasswd'

use Rack::Lint
use Rack::ShowExceptions
use Rack::Reloader
use Rack::CommonLogger
use Rack::Static, :urls => ['/theme'], :root => '.'

class PreBasicAuth
  def initialize(app, file = '.htpasswd')
    @app = app
    @authenticator = ::Rack::Auth::Basic.new(@app) do |user, pass|
      htpasswd = WEBrick::HTTPAuth::Htpasswd.new(file)
      crypted = htpasswd.get_passwd(nil, user, false)
      crypted == pass.crypt(crypted) if crypted
    end
  end

  def call(env)
    if env["REQUEST_URI"] =~ /^\/\?pre-.*/
      @authenticator.call(env)
    else
      @app.call(env)
    end
  end
end

map '/' do
  use PreBasicAuth, '.htpasswd'
  run Hiki::App.new('hikiconf.rb')
end

map '/attach' do
  run Hiki::Attachment.new('hikiconf.rb')
end
