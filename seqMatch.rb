require 'rubygems'

cs_files = Dir.glob("/Users/cjose/Desktop/scripts/*.csfasta")
qual_files = Dir.glob("/Users/cjose/Desktop/scripts/*.qual")

f3_file = File.open(cs_files[0])
f5_file = File.open(cs_files[1])

f3_out = File.new("/Users/cjose/Desktop/f3.csfasta", "w")
f5_out = File.new("/Users/cjose/Desktop/f5.csfasta", "w")

while !f3_file.eof? && while !f5_file.eof?
		f3_ln = f3_file.readline.chomp
		f5_ln = f5_file.readline.chomp
		if f3_ln =~ /^>\d*_\d*_\d*_F3$/
			f3_headers = f3_ln.gsub(/F3/, "")		
		end
		if f5_ln =~ /^>\d*_\d*_\d*_F5-P2$/
			f5_headers = f5_ln.gsub(/F5-P2/, "")
			if f3_headers == f5_headers
				puts f3_headers
				puts f5_headers
				puts "worked"
			else
				puts f3_headers
				puts f5_headers
				puts "nope"
			end
		end

	end # end while	
end # end while

