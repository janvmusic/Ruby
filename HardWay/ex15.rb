filename = ARGV.first

prompt = "> "
txt = File.open(filename)

puts "Here's your file #{filename}"
puts "\n"
puts "==========#{filename}=========="
puts txt.read()
puts "=======End of #{filename}======"

puts "\nI'll also ask you to type it again:"
print prompt

file_again = STDIN.gets.chomp()
txt_again = File.open(file_again)

puts "\n"
puts "==========#{filename}=========="
puts txt_again.read()
puts "=======End of #{filename}======"
puts "\n"

#close the files
txt.close()
txt_again.close()
