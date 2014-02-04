require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'

get '/' do
  'Most common words spoken during arrest, per neighborhood in Boston'
end
