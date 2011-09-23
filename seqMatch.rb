require 'rubygems'

f3_cs_qual = Dir.glob("/Users/cjose/Desktop/scripts/*csfasta")

f3_cs_file = File.open(f3_cs_qual[0]) # csfasta
f5_cs_file = File.open(f3_cs_qual[1]) # qual

f3_cs_out = File.new("/Users/cjose/Desktop/f3_out.csfasta", "w")
f5_cs_out = File.new("/Users/cjose/Desktop/f5_out.csfasta", "w")

while !f5_cs_file.eof? && !f3_cs_file.eof?
  f3_ln = f3_cs_file.readline.chomp
  f5_ln = f5_cs_file.readline.chomp
  f3_ln =~ /^>(\d*_\d*_\d*_)/
  f3_id = $1
  f5_ln =~ /^>(\d*_\d*_\d*_)/
  f5_id = $1

  if f3_id == f5_id 
    f3_cs_out.puts f3_ln
    f3_cs_out.puts f3_cs_file.readline 
    f5_cs_file.readline 
  else
    f5_cs_file.readline
    ctr = 0
    break_pos = f5_cs_file.pos          
    while ctr < 10 # check next 7 entries 
    f5_ln = f5_cs_file.readline.chomp
      if f3_ln =~ /^>/
        if f3_ln =~ /#{f3_id}/
          f3_cs_out.puts f3_ln
          f3_cs_out.puts f3_cs_file.readline
          f5_cs_file.readline
          break
        else
          f3_cs_file.readline
          ctr += 1
        end #end if
       end
    end 
		f5_cs_file.pos = break_pos
  end #end top level if
end 

f3_cs_file.close
f3_cs_out.close
f5_cs_file.close

f5_cs_file = File.open(f3_cs_qual[1])
f3_prime = File.open("/Users/cjose/Desktop/f3_out.csfasta", "r")

while !f5_cs_file.eof? && !f3_prime.eof?
  f3_pos = f3_prime.pos
  f3_pr_ln = f3_prime.readline.chomp
  f5_ln = f5_cs_file.readline.chomp
  f5_ln =~ /^>(\d*_\d*_\d*_)/
  f5_id = $1
  f3_pr_ln =~ /^>(\d*_\d*_\d*_)/
  f3_pr_id = $1

  if f5_id == f3_pr_id
    f5_cs_out.puts f5_ln
    f5_cs_out.puts f5_cs_file.readline
    f3_prime.readline 
  else
    f3_prime.pos = f3_pos
    f3_prime.readline
    ctr = 0          
    f5_pos = f5_cs_file.pos
    while ctr < 10
    f5_ln = f5_cs_file.readline.chomp
   	if f5_ln =~ /^>/
    	if f5_ln =~ /#{f3_pr_id}/
      	f5_cs_out.puts f5_ln
      	f5_cs_out.puts f5_cs_file.readline
      	f3_prime.readline
        f5_pos = f5_cs_file.pos
        f3_pos = f3_prime.pos
        break
      else
      	f5_cs_file.readline
        ctr += 1 
      end # end if
   end
  end 
		#f3_prime.pos = break_pos
  end # end top level if
end 
