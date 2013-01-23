formater = "%s %s %s %s"

puts formater % [1,2,3,4]
puts formater % ["one","two","three","four"]
puts formater % [true,false,false,true]
puts formater % [formater,formater,formater,formater]
puts formater % [
	"I had this thing",
	"that you could type up right",
	"but it didn't sing",
	"so I said good night."
]