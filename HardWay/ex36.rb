####################################################################################
#### Author: Jorge A. Nunez V. 													####
#### Version: 1.2.1																####
#### TODO section:  														    ####
####  - Enh If there are more cities than monsters, the program will crash      ####
####  - Enh What about if exists 1000 of cities? the menu will be so complex    ####
####  - Enh better Life bars    												####
####  - Enh traps 			    												####
####  - Enh More bosses		    												####
####  - Enh Quest to beat'em all   												####
####  - Enh More attacks for player/boss										####
#### Fixed section:  														    ####
####  - Fixed guard issue when bAtk/pAtk										####
####  - Fixed Y when secret_stage        										####
####  - Fixed message for Alberta        										####
####  - Fixed Added status bar to guard and shield status						####
####################################################################################

#Create the array for the cities & maps
$cities = ['Prontera','Alberta','Geffen']
$messages = ['Capital of Midgard','Dock of Midgard','Capital of Wizards']
$maxAtk = ['Death Scythe!','Water Ball!','Tsubame Gaeshi']
$boss = ['Baphomet','Drake','Doppelganger']
$boss_life = [15,11,10]
$boss_atk = [1,1,1]

#Key to open new stages!
$secretKey = false

#stage 2
$citiesS2 = ['Nifflheim','Morroc','Glast Heim']
$messagesS2 = ['Capital of Midgard','Home of Ancient Clock','Capital of Wizards']
$maxAtkS2 = ['Death Space!','Demonic Smack !','Nightmare!']
$bossS2 = ['Lord of Death','Satan Morroc','Dark Lord']
$boss_lifeS2 = [12,20,15]
$boss_atkS2 = [2,2,2]

#add a prompt sign
def prompt()
	print "> "
end

#print the status bars
def statusBar(life,boss_life,boss_name,shield)
	#player life bar.. this one is easy
	player = "Player ["
	for i in 1..life.to_i()
		player << "="
	end
	player << "] #{life} / 10 "
	player << "Shield: #{shield}"
	puts player

	#boss lifebar
	boss = "#{boss_name} ["
	boss_life_total = boss_life(boss_name)
	for i in 1..boss_life
		boss << "="
	end
	boss << "]  #{boss_life} / #{boss_life_total}"
	puts boss
end

#checks if the option is numeric
def isNumeric(number) 
   true if Integer(number) rescue false
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
	puts "Thanks for save us, #{current_city} city will be always in debt with you"
	
	if $secretKey == false
		"Thank you for save #{current_city}, You are a true hero!"
		dead()
	end

	puts "Do you want to continue? Yes/No"
	prompt; next_move = gets.chomp

	if next_move == "Yes" || next_move == "yes" || next_move == "y" || next_move == "Y"
		city(current_city,"Capital of Midgard")
	elsif next_move == "No" || next_move == "no" || next_move == "n" || next_move == "N
		"
		puts "Enjoy your party hero"
		dead()
	else
		puts "You drunk hero, go home"
		dead()
	end	
end

#Use this when player attacks
def pAtk(boss_life,hit)
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
def bAtk(life,hit,boss_name)
	atk = getBossPower(boss_name)

	if $secretKey == false
		critical = rand(1..10)
	elsif $secretKey == true
		critical = rand(1..5)
	else
		puts "Something happened"
		dead()
	end

	#let's hit the boss
	if critical % 3 == 0
		puts "#{boss_name}: #{atk}!! hit x #{hit * critical}"
		life = life - (hit * critical)
	else
		life = life - hit
	end
end

#get boss power!
def getBossPower(boss_name)
	if $secretKey == true
		boss_index = $bossS2.index(boss_name)
		return $maxAtkS2[boss_index]
	else
		boss_index = $boss.index(boss_name)
		return $maxAtk[boss_index]
	end
end

#get boss name
def boss_name(current_city)
	if $secretKey == true
		boss_index = $citiesS2.index(current_city)
		return $bossS2[boss_index]
	else
		boss_index = $cities.index(current_city)
		return $boss[boss_index]
	end
end

#set boss life
def boss_life(boss_name)
	if $secretKey == true
		boss_index = $bossS2.index(boss_name)
		return $boss_lifeS2[boss_index]
	else
		boss_index = $boss.index(boss_name)
		return $boss_life[boss_index]
	end
end

#set boss atk
def boss_atk(boss_name)
	if $secretKey == true
		boss_index = $bossS2.index(boss_name)
		return $boss_atkS2[boss_index]
	else
		boss_index = $boss.index(boss_name)
		return $boss_atk[boss_index]
	end
end

#get currenty city message
def getCurrentCityMessage(current_city)
	city_index = $cities.index(current_city)
	return $messages[city_index]
end

#get city index
def getCityS2(current_city)
	city_index = $cities.index(current_city)
	return $citiesS2[city_index]
end

#checks if still alive
def stillAlive(life)
	if life > 0
		return true
	else
		return false
	end
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
		puts "1) Attack"
		puts "2) Guard"
		puts "3) Flee"
		prompt; next_move = gets.chomp

		if next_move.to_i() == 1
			#player attack
			puts "You attempt to attack #{boss_name}"				
			boss_life = pAtk(boss_life,atk)

			if !stillAlive(boss_life)
				clear()
				puts "You are the true hero of #{current_city} city! Hurrah!"
				$secretKey = !$secretKey
				secret_stage(current_city)
			end

			#boss attack
			puts "#{boss_name} attacks you!"
			life = bAtk(life,boss_atk,boss_name)
			clear()

			#checks that both are alive
			if !stillAlive(life)
				clear() 
				puts "You are not ready for this boss."
				puts "Train more and try it again later"
				dead()
			end

			#print lifebars
			statusBar(life,boss_life,boss_name,shield)
			puts ""

		elsif next_move.to_i() == 2 
			if shield <= 0
				puts "watchout! your shield is broken!"
				puts "#{boss_name} attacks you!"
				bAtk(life,boss_atk,boss_name)
				clear()

				if !stillAlive(life)
					clear() 
					puts "You are not ready for this boss."
					puts "Train more and try it again later"
					dead()
				end

				#print lifebars
				statusBar(life,boss_life,boss_name,shield)
				puts ""
			elsif shield >= 1
				shield = shield - 1
				puts "Your shield protects your from the attack"
				puts "Shield: #{shield}"
				puts "You attempt to attack #{boss_name}"				
				boss_life = pAtk(boss_life,atk)
				
				if !stillAlive(boss_life)
					clear()
					puts "You are the true hero of #{current_city} city! Hurrah!"
					$secretKey = !$secretKey
					secret_stage(current_city)
				end

				#print lifebars
				statusBar(life,boss_life,boss_name,shield)
				puts ""

				clear()
			end
		elsif next_move.to_i() == 3 
			clear()
			puts "Shame on you..."
			puts "You ran out of the dungeon... like a chicken"
			city(current_city,getCurrentCityMessage(current_city))
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
		$secretKey = false
		boss_fight(current_city,boss_name(current_city))
	elsif next_move.to_i() == 2
		if $secretKey == true
			puts "Oh you're the true hero!..."
			puts "I'll be glad to help you in this quest!"
			current_city = getCityS2(current_city)
			boss_fight(current_city,boss_name(current_city))
		else
			puts "You need to be premium user to use this teleport service"
			city(current_city, message)
		end
	elsif next_move.to_i() == 3
		clear()
		kafra_teleport()
	else
		clear()
		puts "Guards confuse you with a murderer!...dead"
		dead()
	end
end

#Kafra teleport service
def kafra_teleport()
	current_city = ""
	puts "Welcome to Kafra teleport service"	
	puts "Where do you want to go?"

	i = 1

	#show the list of available cities
	for city in $cities
		puts "#{i}) #{city}"
		i = i + 1
	end
	prompt; next_move = gets.chomp

	#Teleport to..
	if isNumeric(next_move)
		current_city = $cities[next_move.to_i()-1]
		message = getCurrentCityMessage(current_city)
		puts "Let's move to #{current_city}"
		city(current_city, message)
	else
		clear()
		puts "That's not a city..."
		puts "Kafra teleports you anyway"
		puts "Unfortunately you got stuck between dimensions...dead"
		dead()
	end
end

#Let's play a game
def start()
	kafra_teleport()
end

start()