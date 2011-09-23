require 'rubygems'

f3_cs_qual = Dir.glob("/Users/cjose/Desktop/subset/*csfasta")
#f5_cs_qual = Dir.glob("/Users/cjose/Desktop/files/*F5-P2*")

f3_cs_file = File.open(f3_cs_qual[0]) # csfasta
f3_qual_file = File.open(f3_cs_qual[1]) # qual

f3_cs_out = File.new("/Users/cjose/Desktop/f3_out.csfasta", "w")
f3_qual_out = File.new("/Users/cjose/Desktop/f3_out.qual", "w")

while !f3_qual_file.eof? && !f3_cs_file.eof?
  f3_ln = f3_cs_file.readline.chomp
  f3_qual_ln = f3_qual_file.readline.chomp
  f3_ln =~ /^>(\d*_\d*_\d*_)/
  f3_id = $1
  f3_qual_ln =~ /^>(\d*_\d*_\d*_)/
  f3_qual_id = $1

  if f3_id == f3_qual_id 
    f3_cs_out.puts f3_ln
    f3_cs_out.puts f3_cs_file.readline 
    f3_qual_file.readline 
  else
    f3_qual_file.readline
    ctr = 0
    break_pos = f3_qual_file.pos          
    while ctr < 10 # check next 7 entries 
    f3_ln = f3_qual_file.readline.chomp
      if f3_ln =~ /^>/
        if f3_ln =~ /#{f3_id}/
          f3_cs_out.puts f3_ln
          f3_cs_out.puts f3_cs_file.readline
          f3_qual_file.readline
          break
        elsif ctr == 6
          f3_cs_file.readline
          ctr += 1
        end #end if
       end
    end 
		f3_qual_file.pos = break_pos
  end #end top level if
end 

f3_cs_file.close
f3_cs_out.close
f3_qual_file.close

f3_qual_file = File.open(f3_cs_qual[1])
f3_prime = File.open("/Users/cjose/Desktop/f3_out.csfasta", "r")

while !f3_qual_file.eof? && !f3_prime.eof?
  f3_pos = f3_prime.pos
  f3pr_ln = f3_prime.readline.chomp
  f3_qual_ln = f3_qual_file.readline.chomp
  f3_qual_ln =~ /^>(\d*_\d*_\d*_)/
  f3_qual_id = $1
  f3pr_ln =~ /^>(\d*_\d*_\d*_)/
  f3pr_id = $1

  if f3_qual_id == f3pr_id
    f3_qual_out.puts f3_qual_ln
    f3_qual_out.puts f3_qual_file.readline
    f3_prime.readline 
  else
    f3_prime.pos = f3_pos
    f3_prime.readline
    ctr = 0          
    f5_pos = f3_qual_file.pos
    while ctr < 10
    f3_qual_ln = f3_qual_file.readline.chomp
   	if f3_qual_ln =~ /^>/
    	if f3_qual_ln =~ /#{f3pr_id}/
      	f3_qual_out.puts f3_qual_ln
      	f3_qual_out.puts f3_qual_file.readline
      	f3_prime.readline
        f5_pos = f3_qual_file.pos
        f3_pos = f3_prime.pos
        break
      else
      	f3_qual_file.readline
        ctr += 1 
      end # end if
   end
  end 
		#f3_prime.pos = break_pos
  end # end top level if
end 
