files = Dir.glob("/Users/cjose/scripts/*csfasta")
f3_file = File.open(files[0], "r")
f5_file = File.open(files[1], "r")
f3_out = File.new("/Users/cjose/Desktop/f3out.csfasta", "w")

# F3 against F5 => F3`
while !f5_file.eof? && !f3_file.eof?
  f3_ln = f3_file.readline
  f5_ln = f5_file.readline
  f3_ln =~ /^>(\d*_\d*_\d*_)/
  f3_id = $1
  f5_ln =~ /^>(\d*_\d*_\d*_)/
  f5_id = $1

  if f3_id == f5_id 
    f3_out.puts f3_ln
    f3_out.puts f3_file.readline
    f5_file.readline
  else
    f5_file.readline # start of next header line
    f5_pos = f5_file.pos
    ctr = 0
    while ctr < 7
      f5_buf = f5_file.readline
      if f5_buf =~ /^>/
        if f5_buf =~ /#{f3_id}/
          f3_out.puts f3_ln
          f3_out.puts f3_file.readline
          f5_file.pos = f5_pos
          break
        else
          f5_file.readline
          ctr += 1
          f3_file.readline if ctr == 7
          f5_file.pos = f5_pos if f5_file.eof?
        end
      end
    end
  end
end    

f3_file.close 
f3_out.close
f5_file.rewind

# F5 against F3` => F5`
f3_out = File.open("/Users/cjose/Desktop/f3out.csfasta","r")
f5_out = File.new("/Users/cjose/Desktop/f5out.csfasta", "w")
while !f5_file.eof? && !f3_out.eof?
  f3_out_ln = f3_out.readline
  f5_ln = f5_file.readline
  f3_out_ln =~ /^>(\d*_\d*_\d*_)/
  f3_out_id = $1
  f5_ln =~ /^>(\d*_\d*_\d*_)/
  f5_id = $1

  if f5_id == f3_out_id 
    f5_out.puts f5_ln
    f5_out.puts f5_file.readline
    f3_out.readline
  else
    f3_out.readline
    f3_out_pos = f3_out.pos
    ctr = 0
    while ctr < 7
      f3_out_buf = f3_out.readline
      if f3_out_buf =~ /^>/
        if f3_out_buf =~ /#{f5_id}/
          f5_out.puts f5_ln
          f5_out.puts f5_file.readline
          f3_out.pos = f3_out_pos
        else
          f3_out.readline
          ctr += 1
          f5_file.readline if ctr == 7 && f3_out.eof?
          f3_out.pos = f3_out_pos if f3_out.eof?
        end
      end
    end
  end
end
 
