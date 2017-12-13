=begin
Understanding Applied Network Analytics
Brandon Cruz, Jack Platten, Antonio Soto
CST 499
=end

#Reading in filename
filename = ARGV.first
#filename for cleaned netstat file
cleanFilename = "clean" + filename.capitalize
#creating clean netstat file
cleanTarget = File.open(cleanFilename, 'w')
cleanTarget.truncate(cleanTarget.size)

#opening netstat file
netfile = File.open(cleanFilename)
puts "Here's the file: #{filename}"
#puts netfile.read()

#-----------------CLEANING-----------------#
#Removed the first 4 lines as they're just labels 
counter = 0
netfile.each do |line|
	if counter < 4
		counter += 1
	else
		#puts line
		cleanTarget.write(line)
	end
end
netfile.close

#-----------------PARSING-----------------#
#Creating array holding all capture info
capture = Array.new
#Creating index to feed into capture array
cap_node = 0

netfile = File.open(cleanFilename)
#Iterating over each line
netfile.each_line { |line|
	words = line.split
	capture[cap_node] = {
		"local_address" => words[1],
		"foreign_address" => words[2],
		"state" => words[3]
	}
	cap_node += 1
}
netfile.close

#Printing the individual nodes and their values
counter=0
capture.each { |node|
	puts "Node " + counter.to_s
	node.each { |attribute, value|
		puts "\t" + "#{attribute}: #{value}"
	}
	counter += 1
}


















