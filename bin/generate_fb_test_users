#!/usr/bin/env ruby

require "faraday"
require "dotenv"
require "colorize"
require "json"

Dotenv.load

app_id = ENV["FACEBOOK_APP_ID"]
app_access_token = ENV["FACEBOOK_APP_ACCESS_TOKEN"]
create_test_user_url = "https://graph.facebook.com/v2.10/#{app_id}/accounts/test-users?access_token=#{app_access_token}"
num_users = ARGV[0].to_i || 10

puts "Creating #{num_users} users".green

users = []

# create some users
num_users.times do |num|
  puts "Creating new user #{num + 1}/#{num_users}..."
  response = Faraday.post create_test_user_url
  json = JSON.parse(response.body)
  puts "Created user #{num + 1}/#{num_users}: #{json["email"]}".green

  users << json

  sleep 1
end

friender = users.shift
friendees = users

# send and confirm friend requests
friendees.each do |friendee|
  send_friend_request_url = "https://graph.facebook.com/v2.10/#{friender["id"]}/friends/#{friendee["id"]}?access_token=#{friender["access_token"]}"
  confirm_friend_request_url = "https://graph.facebook.com/v2.10/#{friendee["id"]}/friends/#{friender["id"]}?access_token=#{friendee["access_token"]}"

  puts "Sending friend request from #{friender["email"]} to #{friendee["email"]}..."
  request_response = Faraday.post send_friend_request_url
  if request_response.success?
    puts "Friend request sent!".green
  end

  puts "Confirming friend request..."
  confirmation_response = Faraday.post confirm_friend_request_url
  if confirmation_response.success?
    puts "Friend request confirmed 👬!".green
  end

  sleep 1
end

puts "Log in to your app as #{friender["email"]} at #{friender["login_url"]}\n".green
puts "See all friends at https://graph.facebook.com/v2.10/#{friender["id"]}/friends?access_token=#{friender["access_token"]}".light_blue
