#Create the array for the cities & maps
prontera = ['Prontera','Geffen','Mt Mjolnir','Alberta']
alberta = ['Alberta','Prontera','Geffen','Morroc']
geffen = ['Geffen','Prontera','Alberta','Nifflheim','Glast Heim']

def prompt()
	print "> "
end

def clear()
	for i in (1..3)
		puts ""
	end
end

def dead()
	Process.exit(0)
end

#Protera city
def prontera()
	clear()
	puts "Welcome to #{prontera[0]}, Capital of Midgard"
	puts "What do you want to do?"
	puts "1) Fight boss"
	puts "2) Move other city"
	prompt; next_move = gets.chomp

	if next_move.to_i() == 1
		puts "Entering dungeon"
		dead()
	elsif next_move.to_i() == 2
		kafra_teleport()
	else
		puts "Guards: What was that! He is a buggler! trap him/her!!"
		puts "The guards confuse you with a buggler, You are dead"
		dead()
	end
end

#Geffen City
def geffen()
	clear()
	puts "Welcome to #{geffen[0]}, Capital of Wizards"
	puts "What do you want to do?"
	puts "1) Fight boss"
	puts "2) Move other city"
	prompt; next_move = gets.chomp

	if next_move.to_i() == 1
		puts "Entering dungeon"
		dead()
	elsif next_move.to_i() == 2
		kafra_teleport()
	else
		puts "Guards: What was that! He is a buggler! trap him/her!!"
		puts "The guards confuse you with a buggler, You are dead"
		dead()
	end
end

def alberta()
	clear()
	puts "Welcome to #{alberta.first}, city of biggest clock in Midgard"
	puts "What do you want to do?"
	puts "1) Fight boss"
	puts "2) Move other city"
	prompt; next_move = gets.chomp

	if next_move.to_i() == 1
		puts "Entering dungeon"
		dead()
	elsif next_move.to_i() == 2
		kafra_teleport()
	else
		puts "Guards: What was that! He is a buggler! trap him/her!!"
		puts "The guards confuse you with a buggler, You are dead"
		dead()
	end
end

#Kafra teleport service
def kafra_teleport()
	puts "Welcome to Kafra teleport service"	
	puts "Where do you want to go?"
	puts "1) #{prontera.first}"
	puts "2) #{geffen[0]}"
	puts "3) #{alberta[0]}"
	prompt; city = gets.chomp

	#Teleport to...
	while true
		if city.to_i() == 1
			puts "Let's move to #{prontera[0]}"
			# prontera()
		elsif city.to_i() == 2
			puts "Let's move to #{geffen[0]}"
			# geffen()
		elsif city.to_i() == 3
			puts "Let's move to #{alberta[0]}"
			alberta()
		else
			puts "That's not a city"
			dead()
		end
	end
end

def start()
	kafra_teleport()
end

start()