#extra credit add a limit variable
def fillArray(lim)
	i = 0
	numbers = []
	while i < lim
		# puts "At the top i is #{i}"
		numbers.push(i)
		i += 1
		# puts "Numbers now : #{numbers}"
		# puts "At the bottom i is #{i}"
	end
	return numbers
end

puts "The numbers"
numbers = fillArray(8)
for num in numbers	
	puts num
end

