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
    f5_file.readline 
  else 
    f5_file.readline
    f5_pos = f5_file.pos  
    puts f5_pos
    buffer = []
    ctr = 0
    max_buff = 7 # entries in buffer
    buffer.push f5_ln # push current F5 line      
    while ctr < max_buff  
    ln = f5_file.readline.chomp
      if ln =~ /^>/
        buffer.push ln
        ctr += 1
      end #end if
    end # end while
    
    buffer.each do |header|
      if header =~ /#{f3_id}/
         f3_out.puts f3_ln
         f3_out.puts f3_file.readline
       else
         #f3_file.readline # next entry
       end
    end # end do iterator
    buffer.clear
    #p f5_pos
    f5_file.rewind
    h = f5_file.read(f5_pos) 
    puts h
  end #end top level if

end # end while

f3_file.close
f5_file.close