my_name = 'Jorge A. Nunez'
my_age = 25 #I'm old D:!
my_weight = 60 #In kg
my_height = 1.73 #In meters
my_eyes = 'Brown'
my_teeth = 'White'
my_hair = 'Brown'

puts "Let's talk about %s." % my_name
puts "He's %.2f m tall" % my_height
puts "Actually he is kind of skinny"
puts "He's got %s eyes and %s hair" % [my_eyes, my_hair]
puts "And as a random thing He's got %s teeths" % my_teeth

#this line is tricky, try to get it exactly right
puts "If I add %d, %.2f, and %d I get %.2f" % [my_age, my_height, my_weight, my_age + my_height + my_weight]