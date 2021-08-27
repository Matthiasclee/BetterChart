require 'json'
require 'httparty'
require './chart.rb'
system("clear")
now = Time.now.to_s.split(" ")[0]
timestamp = ARGV[0]
olddate = Time.at(Time.now.to_i - (86400 * (timestamp.to_i - 1))).to_s.split(" ")[0]
olddate = "2010-07-17"
data = JSON.parse(HTTParty.get("https://api.coindesk.com/v1/bpi/historical/close.json?start=#{olddate}&end=#{now}"))["bpi"]
prices = data.values
puts chart(prices, "$", "=")






