def prompt
	print "> "
end

puts "You enter a dark room with two doors. Do you go through door #1 or door #2?"
prompt; door = gets.chomp

if door == "1"
	puts "There's a giant bear here eating a corpse. What do you do?"
	puts "1. Run for your life"
	puts "2. Scream at the bear and fight it with an axe"
	prompt; bear = gets.chomp

	if bear == "1"
		puts "The bear eats your face off. Well done! he runs faster than you!"
	elsif bear == "2"
		puts "The bear eats your legs off. Dude really just an axe?"
	else
		puts "I really don't know what happened, Did you really pee'd the bear?"
	end
elsif door == "2"
	puts "You stare into the endless abyss at Cthuhlu's retina."
	puts "1. Blueberries."
	puts "2. Yellow jacket clothespins."
	puts "3. Understanding revolvers yelling melodies."

	prompt; insanity = gets.chomp
	if insanity == "1" or insanity == "2"
		puts "Your body survives powered by a mind of jello, Good job!"
	else
		puts "You discovered that it was Itachi's Sharingan, He lol'd at you"
	end
else
	puts "You stumble around and fall on a knife and die. Good Job!"
end
