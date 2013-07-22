require_relative "./room"

class PoliticsRoom < Room
    attr_accessor :name, :description, :paths, :message, :previousRoom, :score, :hint

    def initialize(name,description)
        @name = name
        @description = description
        @paths = {}
        @message = ""
        @previousRoom = ""
        @startRoom = "Morris Kidnaped"
        @score = 50
    end

    def go(direction)

        if !@paths.include? direction
            @paths['genericDeath']
        else
            @paths[direction]
        end
    end

    # Sets
    def setMessage(action)

        if action == "" || nil 
            @message = @@MESSAGES['gameOver']
        elsif !@@MESSAGES.include?action
            @message = @@MESSAGES['gameOver']
        else
            @message = @@MESSAGES[action]
        end
            
    end

    def getRoomHint(room)

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
            @hint = @@HINTS['wrongHint']
        end
    end

    def getStartRoom()
        POLITICSSTART
    end

    def getDeathRoom()
        POLITICSDEATH
    end

    def getEndRoom()
        return 'The End'
    end
end


# Rooms!
morrisKidnapped = PoliticsRoom.new("Morris Kidnaped",
    %q{
    Candigato Morris was kidnapped!No mater what, You have to find
    him! Go to this address and find any hint that We could use to
    track this cat. Remember we don't know who we are fighting. 
    Be careful</br></br>

    After you track the address, you got into a warehouse, there's
    nothing strange, everything seems normal, suddenly you notice
    that someone is looking at you.</br></br>
    }
)

secretCorridor = PoliticsRoom.new("Secret Corridor",
    %q{
    After you quietly chase the suspect, you found a secret corridor.
    You move as fast as you can but then you reach the end of the
    corridor. There's a door and 2 tough guys.</br></br>

    After they see you, they ask you if you are the Markus, the new 
    delivery guy, and You, of course, follow the game. Now you are 
    Marcus the body deliver. One of them see that you are sweating and ask
    you if you are ok. He says " You look nervious Markus, if thats 
    your real name."</br></br>

    The second guard doubts about you and asks you for the secret password
    </br></br>

    }
)

insideRoom = PoliticsRoom.new("Inside Room",
    %q{
    You got really lucky, the guards let you in, they tell you what body
    you have to dispose. Curiously you ask about who were them? they tell
    you that these bodies were from people who asks a lot</br></br>

    Suddenly you look around and you see him, there's Morris jailed! It's your
    opportunity to save him. You know the guards have the keys so you need
    to get the keys. </br></br>
    }
)

escapeTime = PoliticsRoom.new("Escape Time",
    %q{
    After you put them a sleep, you take the keys and open the jail. Quickly you have
    to scape from there. You then notice that you didn't lock the key and someone
    open the door. Faster than you, the new guard shoot at you. Luckly you dodged it
    </br></br>

    You take Morris and run to the exit, there are 3 doors you don't have time to 
    investigate to where which door is gonna take you so you have to choose 1 fast!
    </br></br>
    }
)

theEndWinner = PoliticsRoom.new("The End",
    %q{
    You open the door number 2, for a few minutes you run and run! but at the end
    of the tunnel you see a light within the light you see your team and they help you
    to scape and capture the guards.</br></br>

    Finally El Candigato Morris is free.
    }
)

genericDeath = PoliticsRoom.new("Game Over","You died")

# Messages
door1 = 
    %q{
    You jump into door number 1 and found that both doors get you to the same place...
    A room full a guards, they get you and take you to the jail. now you are waiting for
    your time. El candigato Morris thanks your and they finally kill you.</br></br>

    You were too close. Game Over.</br></br>
    }

door3 = 
    %q{
    You jump into door number 3, but inmediatly you got shoot by the guard who was chasing you
    </br></br>
    You were too close. Game Over.
    }

failEscape =
    %q{
    You tried to run away unfortunately you step into a hole and you death!</br></br>

    Game Over!
    }

shootRoom =
    %q{
    You shoot 2 times, but you can't see anything, suddenly you got hit in the head.
    Then you wake up in a room, tied up next to El Candigato. Unfortunatelly El candigato is dead</br></br>

    Game Over
    }

fightThem = 
    %q{
    You run furiously to fight the guards, and like James Bond you hit them hard and fast, Knock them out.
    Now you get the keys from one of the guards. Before leave the room, you check that you didn't forget anything
    unfortunatelly you wake up a guard and quckly he shoots you.</br></br>

    You slowly die. Game Over
    }

gameOver = 
%q{
    What was that? Probably that's wasn't a good idea, I mean you made that Guard
    furious, be careful, He has a shotgun! *shoots sound* </br></br>

    Oh My God! You are bleeding, you tried to scape but you are so weak that you
    slowly die in the middle of the forest.
}

@@MESSAGES = {
    'run away' => failEscape,
    'shoot him' => shootRoom,
    'fight them' => fightThem,
    'shoot them' => shootRoom,
    '1' => door1,
    '3' => door3,
    'gameOver' => gameOver
}

# Hints!
morrisKidnappedHint = "Maybe you track him down!"
secretCorridorHint = "If You know spanish, You could say Dispositivo de Viento" 
insideRoomHint = "Oh its a nap time!, The guards seem tired"
escapeTimeRoomHint = "You can hear noises from door 1"
theEndHint = "You won! Congratulations!"
wrongHint = "Woah! I won't give you a hint! You cheater!"

@@HINTS = {
    'Morris Kidnaped' => morrisKidnappedHint,
    'Secret Corridor' => secretCorridorHint,
    'Inside Room' => insideRoomHint,
    'Escape Time' => escapeTimeRoomHint,
    'The End' => theEndHint,
    'wrongHint' => wrongHint
}

# Paths!
morrisKidnapped.addPaths({
    'chase him' => secretCorridor,
    'run away' => genericDeath,
    'shoot him' => genericDeath,
    'genericDeath' => genericDeath
})

secretCorridor.addPaths({
    'Air Gear' => insideRoom,
    'genericDeath' => genericDeath
})

insideRoom.addPaths({
    'fight them' => genericDeath,
    'shoot them' => genericDeath,
    'put them a sleep' => escapeTime,
    'genericDeath' => genericDeath
})

escapeTime.addPaths({
    '1' => genericDeath,
    '2' => theEndWinner,
    '3' => genericDeath,
    'genericDeath' => genericDeath
})

POLITICSSTART = morrisKidnapped
POLITICSDEATH = genericDeath