# Animal is-an object
class Animal
	def initialize(color,food,size)
		@color = color
		@food = food
		@size = size
	end
end

#Dog is-an object
class Dog < Animal
	def initialize(name,color,food,size)
		##Dogs have a name
		super(color,food,size)
		@name = name
	end

	def name()
		return @name
	end

	def bark()
		puts "Bark bark bark!"
	end

	def eat(food)
		puts "The dog eats #{food}"
	end
end

#Cat is an object
class Cat < Animal
	def initialize(name,color,food,size)
		##Cats have a name
		super(color,food,size)
		@name = name
	end

	def name()
		return @name
	end

	def meow()
		puts "Meow! Prrr"
	end

	def eat(food)
		puts "The cat eats #{food}"
	end
end

#Person is an object
class Person
	attr_accessor :pet

	def initialize(name)
		##every people have a name
		@name = name
		
		#a person has-a pet of some kind
		@pet = nil
	end

	def name()
		return @name
	end

	def petName()
		return @pet.name()
	end
end

#Employee is an object
class Employee < Person
	def initialize(name,salary)
		##calls the super initialize
		super(name)
		@salary = salary
	end
end

#fish is an object!
class Fish
end

#Salmon is a fish duh!
class Salmon < Fish
end

#I dont know what is a Halibut BUT!!! is a FISH
class Halibut < Fish
end

def main()
	#pets
	rover = Dog.new("Rover","Brown","Dog Chow","Big")
	santa = Cat.new("Santa","White","Rats","Medium")

	#employees
	mary = Person.new("Mary")
	frank = Employee.new("Frank",120000)

	#employee has a?
	mary.pet = santa
	frank.pet = rover

	flipper = Fish.new
	crouse = Salmon.new
	harry = Halibut.new

	puts "#{mary.name()} and his/her pet is #{mary.petName()}"
	mary.pet().meow()
end

main()