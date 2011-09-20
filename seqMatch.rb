require 'rubygems'

cs_files = Dir.glob("/Users/cjose/Desktop/scripts/*.csfasta")
qual_files = Dir.glob("/Users/cjose/Desktop/scripts/*.qual")

f3_file = File.open(cs_files[0])
f5_file = File.open(cs_files[1])

f3_out = File.new("/Users/cjose/Desktop/f3.csfasta", "w")
f5_out = File.new("/Users/cjose/Desktop/f5.csfasta", "w")

while !f5_file.eof? && !f3_file.eof?
  f3_ln = f3_file.readline.chomp
  f5_ln = f5_file.readline.chomp
  f3_ln =~ /^>(\d*_\d*_\d*_)/
  f3_id = $1
  f5_ln =~ /^>(\d*_\d*_\d*_)/
  f5_id = $1
 
  if f3_id == f5_id 
    f3_out.puts f3_ln
    f3_out.puts f3_file.readline 
    f5_  file.readline 
  else 
    f3_file.readline 
    f5_file.readline   
     ctr = 0
    max_buff = 7 # 8 total (current F5 line)
    # start of buffer storage
    buffer = []
    buffer.push f5_ln   
    while ctr < max_buff  
    ln = f5_file.readline.chomp
      if ln =~ /^>/
        buffer.push ln
        ctr += 1
      end #end if
    end # end while
    p buffer
    buffer.each do |header|
     if header =~ /#{f3_id}/
       f3_out.puts f3_ln
       f3_out.puts f3_file.readline 
     end 
     end # end do iterator
  end #end top level if 
end # while
f3_file.close
f5_file.close