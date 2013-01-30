from_file, to_file = ARGV
script = $0

puts "Copying from #{from_file} to #{to_file}"

#We could do these two on one line too, how?
input = File.open(from_file)
indata = input.read()

puts "Does the output file exists? #{File.exists? to_file}"

output = File.open(to_file,'w')
output.write(indata)

puts "Alright all done :D!"

output.close()
input.close()