def roundToRange(num)
	ret = 10**(num.to_i.to_s.length-1)*(num.to_i.to_s[0].to_i)
	return ret
end
def toRoundedData(prices)
	#Round prices to fit ranges
	roundedData = []
	i = 0
	while i < prices.length
		roundedData.push(roundToRange(prices[i]))
		i = i + 1
	end
	return roundedData
end
def getFullRanges(prices)
	prices = toRoundedData(prices)
	min = prices.min
	max = prices.max
end
def toFinalData(prices)
	prices = toRoundedData(prices)
	final = {}
	#create empty bars
	i = prices.min
	while i < prices.max + 1
		# puts "#{i.to_s} a"
		final[i.to_s] = [0, 0, 0]
		if i.to_s[0] == "9"
			i = 10**i.to_s.length
			# puts "#{i.to_s} b"
		elsif i.to_s[i.to_s.length - 1] == "1"
			i1 = i.to_s[0].to_i + 1
			i = 10**(i.to_s.length - 1) * i1
			# puts "#{i.to_s} c"
		else
			i = 10**(i.to_s.length-1) * (i.to_s[0].to_i + 1)
			# puts "#{i.to_s} d"
		end
	end
	#add real data to final
	i = 0
	while i < prices.length
		if i == 0
			# puts prices[i]
			final[prices[i].to_s][1] = final[prices[i].to_s][1] + 1
		else
			if prices[i-1] == prices[i]
				final[prices[i].to_s][1] = final[prices[i].to_s][1] + 1
			elsif prices[i-1] < prices[i]
				final[prices[i].to_s][0] = final[prices[i].to_s][0] + 1
			elsif prices[i-1] > prices[i]
				final[prices[i].to_s][2] = final[prices[i].to_s][2] + 1
			end
		end
		i = i + 1
	end
	return final
end
def chart(prices, sym = "", rest = "=", up = "↑", down = "↓")
	prices = toFinalData(prices)
	xAxis = prices.keys
	bars = prices.values
	i = xAxis.length - 1
	out = ""
	while i > -1
		a = up * bars[i][0]
		b = rest * bars[i][1]
		c = down * bars[i][2]
		diff = (xAxis.max.length - xAxis[i].length)
		diff = diff + 1
		out = out + "#{sym}#{xAxis[i]}#{" " * diff.to_i} | #{a + c + b}\n#{"-" * (xAxis.max.length + 4)}\n"
		# puts "$#{xAxis[i]}#{" " * diff.to_i} | #{a + c + b}"
		# puts "#{"-" * (xAxis.max.length + 4)}"
		i = i - 1
	end
	return out
end