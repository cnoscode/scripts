require 'rubygems'

cs_files = Dir.glob("/Users/cjose/Desktop/scripts/*.csfasta")
qual_files = Dir.glob("/Users/cjose/Desktop/scripts/*.qual")

f3_file = File.open(cs_files[0])
f5_file = File.open(cs_files[1])

f3_out = File.new("/Users/cjose/Desktop/f3.csfasta", "w")
f5_out = File.new("/Users/cjose/Desktop/f5.csfasta", "w")

while !f5_file.eof? && !f3_file.eof?
  #puts tmpf3_pos = f3_file.pos
  #puts tmpf5_pos = f5_file.pos
  f3_ln = f3_file.readline.chomp
  f5_ln = f5_file.readline.chomp
  f3_ln =~ /^>(\d*_\d*_\d*_)/
  f3_id = $1
  f5_ln =~ /^>(\d*_\d*_\d*_)/
  f5_id = $1
 
  if f3_id == f5_id 
    f3_out.puts f3_ln
    f3_out.puts f3_file.readline # start of next f3 header
    f5_file.readline # start of next f5 header
  else # >1_10_140_F3 and >1_9_1912_F5-P2
    #puts f3_file.readline # outputs last seq line then eof
    f5_file.readline # end of seq for >1_9_1912_F5-P2; start of next header >1_9_8888_F5-P2
    
    ctr = 0
    buffer = []    
    puts buffer = f5_id # >1_9_8888_F5-P2

    if buffer =~ /#{f3_id}/
      f3_out.puts f3_ln
      f3_out.puts f3_file.readline
    else
      f5_file.readline  
    end    
  end
end
f3_file.close
f5_file.close
