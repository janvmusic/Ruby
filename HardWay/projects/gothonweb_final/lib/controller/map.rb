class Room
	attr_accessor :name, :description, :paths, :message, :previousRoom

	def initialize(name,description)
		@name = name
		@description = description
		@paths = {}
		@message = ""
		@previousRoom = ""
	end

	# Misc methods
	def go(direction)
		@paths[direction]
	end

	def addPaths(paths)
		@paths.update(paths)
	end

	def cleanMessage()
		@message = ""
	end

	# Sets
	def setMessage(action)
		@message = @@MESSAGES[action]
	end

	# Gets
	def getHint()
		first,second,third,fourth = @@secretCode.to_s.split('')
		hint = first << "X" << "X" << fourth
	end
end

# Rooms!
centralCorridor = Room.new("Central Corridor",
	%q{
	The Gothons of Planet Percal #25 have invaded your ship and destroyed
	your entire crew.  You are the last surviving member and your last
	mission is to get the neutron destruct bomb from the Weapons Armory,
	put it in the bridge, and blow the ship up after getting into an
	escape pod.

	You're running down the central corridor to the Weapons Armory when
	a Gothon jumps out, red scaly skin, dark grimy teeth, and evil clown 
	costume flowing around his hate filled body.  He's blocking the door
	to the Armory and about to pull a weapon to blast you.
	}
)

laserWeaponArmory = Room.new("Laser Weapon Armory",
	%q{
	Lucky for you they made you learn Gothon insults in 
	the academy. You tell the one Gothon joke you know:
	
	Lbhe zbgure vf fb sng, jura fur fvgf nebhaq gurubhfr, 
	fur fvgf nebhaq gur ubhfr.
	
	The Gothon stops, tries not to laugh, then busts out 
	laughing and can't move. While he's laughing you run 
	up and shoot him square in the head putting him down, 
	then jump through the Weapon Armory door.
	
	You do a dive roll into the Weapon Armory, crouch and
	scan the room for more Gothons that might be hiding.
	It's dead quiet, too quiet. You stand up and run to 
	the far side of the room and find the neutron bomb in
	its container.  

	There's a keypad lock on the box and you need the code
	to get the bomb out.  If you get the code wrong
	then the lock closes forever and you can't
	get the bomb.  

	The code is 4 digits.
	}
)

theBridge = Room.new("The Bridge",
	%q{
	The container clicks open and the seal breaks, letting gas out.
	You grab the neutron bomb and run as fast as you can to the
	bridge where you must place it in the right spot.

	You burst onto the Bridge with the netron destruct bomb under 
	your arm and surprise 5 Gothons who are trying to take control
	of the ship.  Each of them has an even uglier clown costume than
	the last.  

	They haven't pulled their weapons out yet, as they see the active
	bomb under your arm and don't want to set it off.
	}
)

escapePod = Room.new("Escape Pod",
	%q{
	You point your blaster at the bomb under your arm
	and the Gothons put their hands up and start to sweat.
	You inch backward to the door, open it, and then carefully
	place the bomb on the floor, pointing your blaster at it.
	You then jump back through the door, punch the close button
	and blast the lock so the Gothons can't get out.

	Now that the bomb is placed you run to the escape pod to
	get off this tin can.
	
	You rush through the ship desperately trying to make it to
	the escape pod before the whole ship explodes.  It seems like
	hardly any Gothons are on the ship, so your run is clear of
	interference.  You get to the chamber with the escape pods, and
	now need to pick one to take.  Some of them could be damaged
	but you don't have time to look.  There's 5 pods, which one
	do you take?
	}
)

theEndWinner = Room.new("The End",
	%q{
	You jump into pod 2 and hit the eject button.
	The pod easily slides out into space heading to
	the planet below.  As it flies to the planet, you look
	back and see your ship implode then explode like a
	bright star, taking out the Gothon ship at the same
	time.  You won!
	}
)

theEndLoser = Room.new("Wrong Pod",
	%q{
	You jump into a random pod and hit the eject button.
	The pod escapes out into the void of space, then
	implodes as the hull ruptures, crushing your body
	into jam jelly.

	You were too close. Game Over.
	}
)

genericDeath = Room.new("Game Over","You died")

# Messages
shoot = %q{
	Quick on the draw you yank out your blaster and fire it at the Gothon.
	His clown costume is flowing and moving around his body, which throws
	off your aim. Your laser hits his costume but misses him entirely. This
	completely ruins his brand new costume his mother bought him, which
	makes him fly into an insane rage and blast you repeatedly in the face until
	you are dead. Then he eats you.
}

dodge = %q{
	Like a world class boxer you dodge, weave, slip and slide right
	as the Gothon's blaster cranks a laser past your head.
	In the middle of your artful dodge your foot slips and you
	bang your head on the metal wall and pass out.
	You wake up shortly after only to die as the Gothon stomps on
	your head and eats you.
}

throwBomb = %q{
	In a panic you throw the bomb at the group of Gothons
	and make a leap for the door. Right as you drop it a
	Gothon shoots you right in the back killing you.
	As you die you see another Gothon frantically try to disarm
	the bomb. You die knowing they will probably blow up when
	it goes off.
}

hint = %q{
	Lucky you! the first and last digit of the codes are already 
	in the display!
}

wrongCode = 
%q{
	The lock buzzes one last time and then you hear the sickening
	melting sound as the mechanism is fused together.
	You decide to sit there, and finally the Gothons blow up the
	ship from their ship and you die.
}

bridgeDeath = 
%q{
	That's something you think is a good idea? Probably not
	a Gothon found you and shoot you in the back. While you
	exhale your last breathe you can see how all the ship is 
	blown, finally you die in the bast space.
}

wrongPod = 
%{
	You jump into pod %s and hit the eject button.
	The pod escapes out into the void of space, then
	implodes as the hull ruptures, crushing your body
	into jam jelly.
}

gameOver = 
%q{
	What was that? Probably that's wasn't a good idea, I mean you made that Gothon
	furious, be careful, He has a shotgun! *shoots sound* 

	The weapon that he used made you tiny, so now you are in a lab
	locked in a jar. Probably that's worse than be dead.
}

# Here add messages to the arrays
@@MESSAGES = {
	'shoot' => shoot,
	'dodge' => dodge,
	'throw_bomb' => throwBomb,
	'hint' => hint,
	'wrongCode' => wrongCode,
	'bridgeDeath' => bridgeDeath,
	'wrongPod' => wrongPod,
	'gameOver' => gameOver
}

# Let's generate the secret code
@@secretCode = "%s%s%s%s" % [rand(9)+1,rand(9)+1,rand(9)+1,rand(9)+1]

# Paths!
centralCorridor.addPaths({
	'tell a joke' => laserWeaponArmory,
	'joke' => laserWeaponArmory,
	'shoot' => genericDeath,
	'dodge' => genericDeath,
	'*' => genericDeath
})

# Hint the user!
puts "secret_code #{@@secretCode}"
laserWeaponArmory.addPaths({
	@@secretCode => theBridge,
	'*' => genericDeath,
})

theBridge.addPaths({
	'throw the bomb' => genericDeath,
	'slowly place the bomb' => escapePod,
	'*' => genericDeath
})

escapePod.addPaths({
	'2' => theEndWinner,
	'*' => theEndLoser
})

START = centralCorridor
DEATH = genericDeath


