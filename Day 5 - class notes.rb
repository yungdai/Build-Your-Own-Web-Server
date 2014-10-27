# "gets" is a shortcut from Kernel.gets
# "puts" from Kernel.puts

result = gets.chomp
puts result

# Ruby automatically set up this ID
# to the screen with $stdin and $stdout

# File I/O examples
# Read an entire file at once and print it out to the screen


# calling in a file called stuff.txt in read mode
file = File.open("stuff.txt", "r")
contents = file.read
puts contents
file.close

#

# Option 2
# BAD: it doesn't close the file
# puts File.open('stuff.txt', 'r').read


# Option 3
# Using a block automatically closes the file
File.open('stuff.txt', 'r') do |f|
  pus f.read
end

f.close

# Read a file one line at a toime

# File.open(stuff.txt, 'r').each_line do |line|
#   puts line
# end


# Read a file and copy it to another
file_out = File.open('new_stuff.txt', 'w')
file_in = File.open('stuff.txt', 'r')

file_in.each_line do |line|
  file_out.puts line
end

file_out.close
file_in.close

# checking to see if a file exists?

if File.exists?('stuff.txt')
  puts "The stuff.txt file exists"
end

# Redirect standard out
$stdout = File.open("output.log", "a")

puts "Good"
puts "Morning"
puts "Bitmakers!"

$stdout.close


