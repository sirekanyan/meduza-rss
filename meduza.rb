require 'sinatra'
require_relative 'meduza-rss'

get '/' do
  content_type :html
  'hi :)'
end

before do
  content_type :xml, 'charset' => 'utf-8'
end

get '/rss/?' do
  Meduza.rss
end

get '/rss/:feed/?' do |feed|
  if $feeds.include?(feed)
    Meduza.rss(feed)
  else
    redirect '/rss'
  end
end