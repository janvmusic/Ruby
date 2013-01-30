#this one is like your script with ARGV
def puts_two(*args)
	arg1,arg2=args
	puts "arg1: #{arg1}, arg2:#{arg2}"
end

#ok, that *args is actually pointless, we can just do this
def puts_two_again(arg1,arg2)
	puts "arg1: #{arg1}, arg2:#{arg2}"
end

#this just take one argument
def puts_one(arg1)
	puts "arg1: #{arg1}"
end

#this one takes no argument
def puts_none
	puts "I got nothing T_T"
end

puts_two("Jorge","Nunez")
puts_two_again("Jorge","Nunez")
puts_one("Omg!")
puts_none()
