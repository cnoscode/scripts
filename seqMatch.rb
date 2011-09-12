require 'rubygems'

cs_files = Dir.glob("/Users/cjose/Desktop/scripts/*.csfasta")
qual_files = Dir.glob("/Users/cjose/Desktop/scripts/*.qual")

f3_file = File.open(cs_files[0])
f5_file = File.open(cs_files[1])

f3_out = File.new("/Users/cjose/Desktop/f3.csfasta", "w")
f5_out = File.new("/Users/cjose/Desktop/f5.csfasta", "w")

while !f3_file.eof?
  while !f5_file.eof?
    f5_ln = f5_file.readline
    if f5_ln =~ /(\d*_\d*_\d*_)/
      f5_ln += f5_file.readline
    end
  end
  f3_ln = f3_file.readline
  if f3_ln =~ /(\d*_\d*_\d*_)/
    f3_ln += f3_file.readline
  end
  
end

if f3_ln.delete("F3").size == f5_ln.delete("F5-P2").size 
  if true
    f3_out.puts f3_ln
    f5_out.puts f5_ln  
  end
end