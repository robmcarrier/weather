require 'pathname'

require 'logger'
require 'yaml'
require 'rubygems'
require 'bundler/setup'
require 'sinatra'


require 'erb'

APP_ROOT = Pathname.new(File.expand_path(File.dirname(__FILE__)))

Dir[APP_ROOT.join('app', 'controllers', '*.rb')].sort{|a,b| !a.include?("index") ? 1 : -1 <=> b.include?("index") ? -1 : 1}.each { |f| require f }

Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |f| require f }



helpers ApplicationHelper
