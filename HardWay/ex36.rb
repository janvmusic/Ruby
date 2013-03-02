#Create the array for the cities & maps
$prontera = ['Prontera','Nifflheim']
$alberta = ['Alberta','Morroc']
$geffen = ['Geffen','Glast Heim']
$boss = ['Baphomet','Doppelganger','Drake','Satan Morroc','Lord of Death','Dark Lord']
$boss_life = [15,11,10,20,12,15]
$boss_atk = [1,1,1,2,2,2]
$secretKey = false

#add a prompt sign
def prompt()
	print "> "
end

#clear the prompt just a bit
def clear()
	for i in (1..3)
		puts ""
	end
end

#If you want to exit the game
def dead()
	Process.exit(0)
end

#Secret stage
def secret_stage(current_city)
	clear()
	puts "You saved #{current_city} city"
	
	if $secretKey == false
		"Thank you for save #{current_city}, You are a true hero!"
		dead()
	end

	puts "Do you want to continue? Yes/No"
	prompt; next_move = gets.chomp

	if next_move == "Yes"
		city(current_city,"Capital of Midgard")
	elsif next_move == "No"
		puts "Enjoy your party hero"
		dead()
	else
		puts "You drunk, go home"
		dead()
	end
		
end

#Use this when player attacks
def pHit(boss_life,hit)
	critical = rand(1..10)	

	#let's hit the boss
	if critical % 3 == 0
		puts "Player: Martillo de Balgram!! hit x #{hit * critical}"
		boss_life = boss_life - (hit * critical)
	else
		boss_life = boss_life - hit
	end
end

#Use this when boss attacks!
def bHit(life,hit)
	critical = rand(1..10)	

	#let's hit the boss
	if critical % 3 == 0
		puts "Boss: Aurora de Apolo!! hit x #{hit * critical}"
		life = life - (hit * critical)
	else
		life = life - hit
	end
end

#get boss name
def boss_name(current_city)
	
end

#set boss life
def boss_life(boss_name)
	boss_index = $boss.index(boss_name)
	return $boss_life[boss_index]
end

#set boss atk
def boss_life(boss_name)
	boss_index = $boss.index(boss_name)
	return $boss_atk[boss_index]
end

#Let's fight with the right boss
def boss_fight(current_city,boss_name)
	clear()
	puts "Entering #{current_city} dungeon..."
	puts "#{boss_name} is ready to beat you!"
	#create status
	
	life = 10
	atk = 1
	boss_life = boss_life(boss_name)
	boss_atk = boss_atk(boss_name)
	shield = rand(5)
	
	while true
		puts "1) Hit"
		puts "2) Guard"
		puts "3) Status"
		prompt; next_move = gets.chomp

		if next_move.to_i() == 1			
			#check that you are not dead
			if life <= 0
				clear() 
				puts "You are not ready for this boss."
				puts "Train more and try it again later"
				dead()
			elsif life >= 1
				puts "You attempt to hit #{boss_name}"				
				boss_life = pAtk(boss_life,atk)
			end

			#win?!?!
			if boss_life <= 0 
				clear()
				puts "You are the true hero of #{current_city} city! Hurrah!"
				$secretKey = !$secretKey
				secret_stage(current_city)
			elsif boss_life >= 1
				puts "#{boss_name} attacks you!"
				life = bAtk(life,boss_atk)
				clear()
			end
		elsif next_move.to_i() == 2 
			if shield <= 0
				puts "watchout! your shield is broken!"
				puts "#{boss_name} attacks you!"
				bHit(life,boss_hit)
				clear()
			elsif shield >= 1
				shield = shield - 1
				puts "Your shield protects your from the attack"
				puts "Shield: #{shield}"
				clear()
			end

		elsif next_move.to_i() == 3
			clear()
			puts "Life: #{life}" 
			puts "Shield: #{shield}" 
			puts "Boss Life: #{boss_life}" 
		else
			puts "That's not an option"
			puts "Pay attention!...dead"
			dead()
		end
	end
end

#Move to another city
def city(current_city, message)
	clear()
	boss = ""
	puts "Welcome to #{current_city}, #{message}"
	puts "What do you want to do?"
	puts "1) Fight boss"
	puts "2) Move to another city"
	puts "3) Kafra teleport service"
	prompt; next_move = gets.chomp
	
	if next_move.to_i() == 1
		boss_fight(current_city,boss_name(current_city))
	elsif next_move.to_i() == 2
		if $secretKey == true
			current_city = $prontera[1]
			boss_fight(current_city,$prontera[1])
		else
			puts "You need to be premium user to use this teleport service"
			city(current_city, message)
		end
	elsif next_move.to_i() == 3
		clear()
		kafra_teleport()
	end
end

#Kafra teleport service
def kafra_teleport()
	current_city = ""
	puts "Welcome to Kafra teleport service"	
	puts "Where do you want to go?"
	puts "1) #{$prontera.first}"
	puts "2) #{$geffen.first}"
	puts "3) #{$alberta.first}"
	prompt; city = gets.chomp

	#Teleport to...
	while true
		if city.to_i() == 1
			current_city = $prontera.first
			puts "Let's move to #{current_city}"
			city(current_city, "Capital of Midgard")
		elsif city.to_i() == 2
			current_city = $geffen.first
			puts "Let's move to #{current_city}"
			city(current_city,"Capital of Wizards")
		elsif city.to_i() == 3
			current_city = $alberta.first
			puts "Let's move to #{current_city}"
			city(current_city,"home of ancient clock")
		else
			puts "That's not a city..."
			puts "Kafra teleports you anyway"
			puts "Unfortunately you got stuck between dimensions...dead"
			dead()
		end
	end
end

#Let's play a game
def start()
	kafra_teleport()
end

start()