##################################################################################
#### TODO section:  														  ####
####  - Enh If there are more cities than monsters, the program will crash    ####
####  - Enh What about if exists 1000 of cities? the menu will be so complex  ####
####  - bug Problem with boss/player life                                     ####
####  - Enh Flee from a boss                                                  ####
####  - bug criticals / 1 Hit -> KO                                           ####
####  - bug isNumeric Option                                                  ####
##################################################################################

#Create the array for the cities & maps
$cities = ['Prontera','Alberta','Geffen']
$messages = ['Capital of Midgard','Home of Ancient Clock','Capital of Wizards']
$boss = ['Baphomet','Drake','Doppelganger']
$boss_life = [15,11,10]
$boss_atk = [1,1,1]

#Key to open new stages!
$secretKey = false

#stage 2
$citiesS2 = ['Nifflheim','Morroc','Glast Heim']
$bossS2 = ['Lord of Death','Satan Morroc','Dark Lord']
$messagesS2 = ['Capital of Midgard','Home of Ancient Clock','Capital of Wizards']
$boss_lifeS2 = [12,20,15]
$boss_atkS2 = [2,2,2]

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
	puts "Thanks for save us, #{current_city} city will be always in debt with you"
	
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
def bAtk(life,hit)
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

#Let's fight with the right boss
def boss_fight(current_city,boss_name)
	clear()
	puts "Entering #{current_city} dungeon..."
	puts "#{boss_name} is ready to beat you!"
	#create status
	
	life = 10
	atk = 10
	boss_life = boss_life(boss_name)
	boss_atk = boss_atk(boss_name)
	shield = rand(5)
	
	while true
		puts "1) Attack"
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
				puts "You attempt to attack #{boss_name}"				
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
				bAtk(life,boss_atk)
				clear()
			elsif shield >= 1
				shield = shield - 1
				puts "Your shield protects your from the attack"
				puts "Shield: #{shield}"
				puts "You attempt to attack #{boss_name}"				
				boss_life = pAtk(boss_life,atk)
				clear()
			end

		elsif next_move.to_i() == 3
			clear()
			puts "Life: #{life}" 
			puts "Shield: #{shield}" 
			puts "#{boss_name}\'s Life: #{boss_life}" 
			clear()
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
	for city in $cities
		puts "#{i}) #{city}"
		i = i + 1
	end
	prompt; next_move = gets.chomp

	if next_move.include? "0" or next_move.include? "1"	
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

	#Teleport to..
end

#Let's play a game
def start()
	kafra_teleport()
end

start()