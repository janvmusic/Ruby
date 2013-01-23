first, second, third = ARGV

puts "The script is called: #{$0}"
print "What's your name?"
name = STDIN.gets.chop()

puts "So your name is #{name} and you want #{first} #{second} #{third}"
