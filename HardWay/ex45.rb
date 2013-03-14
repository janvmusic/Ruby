# Animal is-an object
class Animal

end

#Dog is-an object
class Dog < Animal
	def initialize(name)
		##Dogs have a name
		@name = name
	end
end

#Cat is an object
class Cat < Animal
	def initialize(name)
		##Cats have a name
		@name = name
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

#pets
rover = Dog.new("Rover")
santa = Cat.new("Santa")

#employees
mary = Person.new("Mary")
frank = Employee.new("Frank",120000)

#employee has a?
mary.pet = santa
frank.pet = rover

flipper = Fish.new
crouse = Salmon.new
harry = Halibut.new