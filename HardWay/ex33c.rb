#Extra credir: Change while/for
def fillArray(lim)
	numbers = []
	for i in (0..lim)
		puts "At the top i is #{i}"
		numbers.push(i)
		puts "Numbers now : #{numbers}"
		puts "At the bottom i is #{i}"
	end
	return numbers
end

puts "The numbers"
numbers = fillArray(8)
for num in numbers	
	puts num
end

