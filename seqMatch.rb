require 'rubygems'
require 'bio'

f3_cs = Bio::FlatFile.auto("/Users/cjose/Desktop/testfiles/MD_20091218_r4200_PE_1s8p50c_Sample1_F3.csfasta")
f5_cs = Bio::FlatFile.auto("/Users/cjose/Desktop/testfiles/MD_20091218_r4200_PE_1s8p50c_Sample1_F5-P2.csfasta")

f3_out = File.new("/Users/cjose/Desktop/f3.csfasta", "w")
f5_out = File.new("/Users/cjose/Desktop/f5.csfasta", "w")

a = []
f3_cs.pos = 0
f5_cs.pos = 0


while f3_entry = f3_cs.next_entry && f5_entry = f5_cs.next_entry
	if f3_entry =~ /^>/
		start_of_entry = f3_cs.pos
		if f3_entry =~ /F3/
			start_of_f3 = f3_cs.pos
			length = start_of_f3 - start_of_entry
			header = f3_entry.read(length)
			f3_out.puts header
		end
	end
end
	
# F3, F5-P2
f3_cs.close
f5_cs.close

 



