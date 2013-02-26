#Extra credit: Add second variable
def fillArray(lim,add)
	i = 0
	numbers = []
	while i < lim
		# puts "At the top i is #{i}"
		numbers.push(i)
		i += add
		# puts "Numbers now : #{numbers}"
		# puts "At the bottom i is #{i}"
	end
	return numbers
end

puts "The numbers"
numbers = fillArray(8,3)
for num in numbers	
	puts num
end

