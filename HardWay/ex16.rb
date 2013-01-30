filename = ARGV.first
script = $0

puts "We're going to erase #{filename}."
puts "If you don't want that hit CTRL-C (^C)."
puts "If you want to continue hit RETURN"

print "? "
STDIN.gets

puts "Opening this file..."
target = File.open(filename,'w')

puts "Truncating the file. Goodbye!"
target.truncate(target.size)

puts "Now I'm going to ask you for three lines."
print "line 1: "; line1 = STDIN.gets.chomp()
print "line 2: "; line2 = STDIN.gets.chomp()
print "line 3: "; line3 = STDIN.gets.chomp()

puts "I'm going to write this to the file."
final_line = "%s \n %s \n %s" % [line1,line2,line3]
target.write(final_line)
puts "And finally close it."
target.close()

puts "Wait WHATTTT!!!"
puts "======Here is the file again======"
open_again = File.open(filename)
puts open_again.read()
puts "=================================="
open_again.close()