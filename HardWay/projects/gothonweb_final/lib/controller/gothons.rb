require_relative './room'

class GothonRoom < Room
	attr_accessor :name, :description, :paths, :message, :previousRoom, :score, :hint

	def initialize(name,description)
		@name = name
		@description = description
		@paths = {}
		@message = ""
		@previousRoom = ""
		@startRoom = "centralCorridor"
		@score = 75
	end

	def go(direction)
		puts "MAZAPAN #{direction}"
		if !@paths.include? direction
			@paths['genericDeath']
		else
			@paths[direction]
		end
	end

	# Sets
	def setMessage(action)
        # Room not nil and well it has a name! laser! bzzzz
        if @previousRoom == 'Laser Weapon Armory' && @name == 'Game Over'
            @message = @@MESSAGES['wrongCode']
        # Get the Wrong Pod message
        elsif @previousRoom == 'Escape Pod' && @name == 'Game Over'
            @message = @@MESSAGES['wrongPod']
        elsif @@MESSAGES.include? action
			@message = @@MESSAGES[action]
		else
			@message = @@MESSAGES['gameOver']
		end 
	end

	def getRoomHint(room)

		puts "MAZAPAN #{room}"
		if room == nil || room == ""
			@hint = @@HINTS['wrongHint']
		elsif @@HINTS.include? room
			if room == 'Laser Weapon Armory'
				first,second,third,fourth = @@SECRETCODE.to_s.split('')
				@hint += third 
			else
				@hint = @@HINTS[room]
			end
		else	
			puts "GOT HERE"
			@hint = @@HINTS['wrongHint']
		end
	end

	def generateHint()
		# Let's generate the secret code
		secretCode = "%s%s%s%s" % [rand(9)+1,rand(9)+1,rand(9)+1,rand(9)+1]
		@@SECRETCODE = secretCode
		puts secretCode
		return secretCode
	end

	def getHint()
		first,second,third,fourth = generateHint().to_s.split('')
		hint = first << "X" << "X" << fourth
	end

	def getStartRoom()
		GOTHONSTART
	end

	def getDeathRoom()
		DEATH
	end

	def getEndRoom()
		return 'The End'
	end
end

# Rooms!
centralCorridor = GothonRoom.new("Central Corridor",
	%q{
	The Gothons of Planet Percal #25 have invaded your ship and destroyed
	your entire crew.  You are the last surviving member and your last
	mission is to get the neutron destruct bomb from the Weapons Armory,
	put it in the bridge, and blow the ship up after getting into an
	escape pod.</br></br>

	You're running down the central corridor to the Weapons Armory when
	a Gothon jumps out, red scaly skin, dark grimy teeth, and evil clown 
	costume flowing around his hate filled body.  He's blocking the door
	to the Armory and about to pull a weapon to blast you.
	}
)

laserWeaponArmory = GothonRoom.new("Laser Weapon Armory",
	%q{
	Lucky for you they made you learn Gothon insults in 
	the academy. You tell the one Gothon joke you know:
	
	Lbhe zbgure vf fb sng, jura fur fvgf nebhaq gurubhfr, 
	fur fvgf nebhaq gur ubhfr.</br>
	
	The Gothon stops, tries not to laugh, then busts out 
	laughing and can't move. While he's laughing you run 
	up and shoot him square in the head putting him down, 
	then jump through the Weapon Armory door.</br>
	
	You do a dive roll into the Weapon Armory, you can see
	that it's dead quiet, too quiet. You stand up and run to 
	the far side of the room and find the neutron bomb in
	its container.  </br>

	There's a keypad lock on the box and you need the code
	to get the bomb out.  If you get the code wrong
	then the lock closes forever and you can't
	get the bomb. The code has 4 digits. </br>

	}
)

theBridge = GothonRoom.new("The Bridge",
	%q{
	The container clicks open and the seal breaks, letting gas out.
	You grab the neutron bomb and run as fast as you can to the
	bridge where you must place it in the right spot.</br></br>

	You burst onto the Bridge with the netron destruct bomb under 
	your arm and surprise 5 Gothons who are trying to take control
	of the ship.  Each of them has an even uglier clown costume than
	the last.  </br></br>

	They haven't pulled their weapons out yet, as they see the active
	bomb under your arm and don't want to set it off.</br></br>
	}
)

escapePod = GothonRoom.new("Escape Pod",
	%q{
	You point your blaster at the bomb under your arm
	and the Gothons put their hands up and start to sweat.
	You inch backward to the door, open it, and then carefully
	place the bomb on the floor, pointing your blaster at it.
	You then jump back through the door, punch the close button
	and blast the lock so the Gothons can't get out.</br></br>

	Now that the bomb is placed you run to the escape pod to
	get off this tin can. You rush through the ship desperately 
	trying to make it to the escape pod before the whole ship explodes.
	It seems like hardly any Gothons are on the ship, so your 
	run is clear of interference. You get to the chamber with
	the escape pods, and now need to pick one to take. 
	Some of them could be damaged but you don't have time to look.
	There's 5 pods, which one do you take?</br></br>
	}
)

theEndWinner = GothonRoom.new("The End",
	%q{
	You jump into pod 2 and hit the eject button.
	The pod easily slides out into space heading to
	the planet below.  As it flies to the planet, you look
	back and see your ship implode then explode like a
	bright star, taking out the Gothon ship at the same
	time.  You won!
	}
)

theEndLoser = GothonRoom.new("Wrong Pod",
	%q{
	You jump into a random pod and hit the eject button.
	The pod escapes out into the void of space, then
	implodes as the hull ruptures, crushing your body
	into jam jelly.

	You were too close. Game Over.
	}
)

genericDeath = GothonRoom.new("Game Over","You died")

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
	bang your head on the metal wall and pass out.</br></br>

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
	furious, be careful, He has a shotgun! *shoots sound* </br></br>

	The weapon that he used made you tiny, so now you are in a lab
	locked in a jar. Probably that's worse than be dead.
}

# Hints!
centralCorridorHint = "Maybe you could say something funny!"
laserWeaponHint = "I'm gonna give you one more number: " 
theBridgeHint = " Don't move that bomb rapidly, be easy, it might explode in any second"
escapePodHint = "Seems that the number 3 is broken! be careful"
theEndHint = "You won! Congratulations!"
wrongHint = "Woah! I won't give you a hint! You cheater!"

@@SECRETCODE=0000

# Here add messages to the arrays
@@MESSAGES = {
	'shoot' => shoot,
	'dodge' => dodge,
	'throw the bomb' => throwBomb,
	'hint' => hint,
	'wrongCode' => wrongCode,
	'bridgeDeath' => bridgeDeath,
	'wrongPod' => wrongPod,
	'gameOver' => gameOver
}

@@HINTS = {
	'Central Corridor' => centralCorridorHint,
	'Laser Weapon Armory' => laserWeaponHint,
	'The Bridge' => theBridgeHint,
	'Escape Pod' => escapePodHint,
	'The End' => theEndHint,
	'wrongHint' => wrongHint
}

# Paths!
centralCorridor.addPaths({
	'tell a joke' => laserWeaponArmory,
	'joke' => laserWeaponArmory,
	'shoot' => genericDeath,
	'dodge' => genericDeath,
	'genericDeath' => genericDeath
})

# Hint the user!
laserWeaponArmory.addPaths({
	@@SECRETCODE => theBridge,
	'*' => genericDeath,
})

theBridge.addPaths({
	'throw the bomb' => genericDeath,
	'slowly place the bomb' => escapePod,
	'genericDeath' => genericDeath
})

escapePod.addPaths({
	'2' => theEndWinner,
	'*' => theEndLoser
})

GOTHONSTART = centralCorridor
DEATH = genericDeath

