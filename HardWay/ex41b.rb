#here docs!
$cc_message = <<CENTRAL_CORRIDOR
The Gothons of Planet Percal 25 have invaded your ship and destroyed
your entire crew. you are the last surviving member and your last
mission is to get the neutron destruct bomb from the Weapons Armory
put it in the bridge, and blow the shop up after getting into an 
scape pod
\n
You're running down the central corridor to the Weapons Armory when
a Gothon jumps out, red scaly skin, dark grimy teeth, and evil clown costume
flowing around his hate filler body. He's blocking the door to the
Armory and about to pull a weapon to blast you
CENTRAL_CORRIDOR

def prompt()
	print "> "
end

def death()
	quips = [
		"You died. You kinda suck at this",
		"Nice Job, You died.... jackass",
		"I have a small puppy that's better at this."
		]
	puts quips[rand(quips.length())]
	Process.exit(1)
end

def central_corridor()
	
	prompt()
	action = gets.chomp()

	if action == "shoot!"

		return :death
	elsif action == "dodge!"

		return :death
	elsif action == "tell a joke!"

		return :laser_weapon_armory
	else
		puts "DOES NOT COMPUTE!"
		return :central_corridor
	end
end

def laser_weapon_armory()

	code = "%s%s%s" % [rand(9)+1,rand(9)+1,rand(9)+1]
	first,second,third = code.to_s().split('')

	#some help!
	puts "#{first} #{third}"


	print "[keypad]> "
	guess = gets.chomp()
	guesses = 0

	while guess != code and guesses < 10
		puts "BZZZZZEDDDDDDDD!"
		guesses += 1
		print "[keypad]> "
		guess = gets.chomp()
	end

	if guess == code

		return :the_bridge
	else 

		return :death
	end
end

def the_bridge()

	
	prompt()
	action = gets.chomp()

	if action == "throw the bomb"

		return :death
	elsif action == "slowly place the bomb"

		return :scape_pod
	else
		puts "DOES NOT COMPUTE!"
		return :the_bridge
	end	
end

def scape_pod()


	good_pod = rand(5) + 1
	if good_pod % 2 == 0
		hint = "ODD"
	else
		hint = "EVEN"
	end
	
	#some help!
	puts "*You find a sign and read its content*"
	puts "DONT USE \"#{hint}\" SHIPS"

	print ["[pod #]> "]
	guess = gets.chomp()

	if guess.to_i() != good_pod
		puts "You jump into pod %s and hit the eject button." % guess
		puts "The pod escapes out into the void of space, then"
		puts "implodes as the hull ruptures, crushing your body"
		puts "into jam jelly."
		return :death
	else
		puts "You jump into pod %s and hit the eject button." % guess
		puts "The pod easily slides out into space heading to"
		puts "the planet below. As it flies to the planet, you look"
		puts "back and see your ship implode then explode like a"
		puts "bright star, taking out the Gothon ship at the same"
		puts "time. You won!"
		Process.exit(0)
	end
end

ROOMS = {
	:death => method(:death),
	:central_corridor => method(:central_corridor),
	:laser_weapon_armory => method(:laser_weapon_armory),
	:the_bridge => method(:the_bridge),
	:scape_pod => method(:scape_pod)
}

MESSAGES = {
	:cc_message => $cc_message,
	:cc_shoot_message => $cc_shoot_message,
	:cc_dodge_message => $cc_dodge_message,
	:cc_joke_message => $cc_joke_message,
	:weapon_armory => $weapon_armory,
	:weapon_armory_wrong => $weapon_armory_wrong,
	:weapon_armory_code => $weapon_armory_code,
	:weapon_armory_cheat => $weapon_armory_cheat,
	:bridge => $bridge,
	:bridge_throw => $bridge_throw,
	:bridge_place_bomb => $bridge_place_bomb,
	:pod => $pod
}

def runner(map,start,message,st_message)
	next_one = start
	next_message = st_message
	while true
		room = map[next_one]
		msg = message[next_message]
		puts msg
		puts "\n============"
		next_one = room.call()
		next_message = msg.call()
	end
end

runner(ROOMS,:central_corridor,MESSAGES,:cc_message)