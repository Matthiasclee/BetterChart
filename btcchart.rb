require 'json'
require 'httparty'
require './chart.rb'
system("clear")
now = Time.now.to_s.split(" ")[0]
if ARGV[0] == nil
	olddate = "2010-07-17"
else
	timestamp = ARGV[0]
	olddate = Time.at(Time.now.to_i - (86400 * (timestamp.to_i - 1))).to_s.split(" ")[0]
end

data = JSON.parse(HTTParty.get("https://api.coindesk.com/v1/bpi/historical/close.json?start=#{olddate}&end=#{now}"))["bpi"]
prices = data.values
puts chart(prices, "$", "*")






