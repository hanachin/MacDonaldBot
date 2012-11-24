#encoding: utf-8

require './calorie.rb'
require 'twitter'
require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

client = TweetStream::Client.new

client.on_timeline_status do |status|
  puts "timeline status"
  puts status.text
  if status.text =~ /^@calorie_bot /
    puts "カロリーボット、返事する。"
    # Twitter.update 'カロリーbotです。'
  end
end

client.userstream