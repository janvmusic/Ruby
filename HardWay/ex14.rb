user = ARGV.first
prompt = "#{$0} >>"

puts "Hi #{user}, I'm the #{$0} script"
puts "I'd like to ask you a few questions."

puts "Do you like SheMusic #{user}?"
print prompt
likes = STDIN.gets.chomp()

puts "Where do you live #{user}?"
print prompt
lives = STDIN.gets.chomp()

puts "What kind of computer do you have?"
print prompt
computer = STDIN.gets.chomp

puts <<MESSAGE
Alright, so you said that #{likes} likes SheMusic.
You live in #{lives}. Not sure where that is.
ANd you have a #{computer} computer. Nice :D!
MESSAGE

