def add(a,b)
	puts "Adding #{a} + #{b}"
	a+b
end

def substract(a,b)
	puts "Substracting #{a} - #{b}"
	a-b
end

def multiply(a,b)
	puts "Multiplying #{a} * #{b}"
	a*b
end

def divide(a,b)
	puts "Dividing #{a} / #{b}"
	a/b
end

puts "Let's do some math with just functions"

age = add(30,5)
height = substract(78,4)
weight = multiply(90,2)
iq = divide(100,2)

puts "Age: %s, Height: %s, Weight: %s, IQ: %s" % [age,height,weight,iq]

# a puzzle for the extra credit, type it anyway
puts "Here is the puzzle"

what = add(age,substract(height,multiply(weight,divide(iq,2))))
puts "That becomes: #{what} Can you do it by hand?" 

puts "Here is my puzzle"

wtf = substract(multiply(age,height),multiply(weight,divide(iq,2)))
puts "really wtf means #{wtf}"