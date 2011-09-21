require 'rubygems'

cs_files = Dir.glob("/Users/cjose/Desktop/scripts/*.csfasta")

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
    ctr = 0          
    while ctr < 7 # check next 7 entries 
    ln = f5_file.readline.chomp
      if ln =~ /^>/
        if ln =~ /#{f3_id}/
          f3_out.puts f3_ln
          f3_out.puts f3_file.readline
          f5_file.readline
          break
        else
          ctr += 1
        end #end if
       end
     end 

  end #end top level if
end 

f3_file.close
f3_out.close
f5_file.close

f5_file = File.open(cs_files[1])
f3_prime = File.open("/Users/cjose/Desktop/f3.csfasta", "r")
f5_file.rewind

while !f5_file.eof? && !f3_prime.eof?
  f3pr_ln = f3_prime.readline.chomp
  f5_ln = f5_file.readline.chomp
  f5_ln =~ /^>(\d*_\d*_\d*_)/
  f5_id = $2
  f3pr_ln =~ /^>(\d*_\d*_\d*_)/
  f3pr_id = $2
   
  if f5_id == f3pr_id
    f5_out.puts f5_ln
    f5_out.puts f5_file.readline 
    f3_prime.readline 
  else
    f3_prime.readline
    ctr = 0          
    while ctr < 7 # 7 entries in buffer
    ln = f3_prime.readline.chomp
      if ln =~ /^>/
        if ln =~ /#{f5_id}/
          f5_out.puts f5_ln
          f5_out.puts f5_file.readline
          f3_prime.readline
          break
        else 
          ctr += 1
        end #end if
      end
    end 

  end #end top level if
end  



