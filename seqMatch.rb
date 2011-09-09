require 'rubygems'
require 'bio'

# find csfasta/qual files 
cs_files = Dir.glob("/Users/cjose/Desktop/testfiles/*.csfasta")
qual_files = Dir.glob("/Users/cjose/Desktop/testfiles/*.qual")

# output files
f3_out = File.new("/Users/cjose/Desktop/f3.csfasta", "w")
f5_out = File.new("/Users/cjose/Desktop/f5.csfasta", "w")

f3_file = Bio::FastaFormat.open(cs_files[0])
f5_file = Bio::FastaFormat.open(cs_files[1])

# header pattern to match
pattern = /[0-9]*[_][0-9]*[_][0-9]*[_]/
f3_headers = []
f5_headers = []

while f3_entry = f3_file.next_entry #&& f5_entry = f5_file.next_entry
  if f3_entry.definition =~ pattern   
    f3_headers.push(f3_entry.definition.gsub(/F3/,""))
  end
  while f5_entry = f5_file.next_entry
    if f5_entry.definition =~ pattern
      f5_headers.push(f5_entry.definition.gsub(/F5/,""))
    end
    f3_headers.each do |f3_line|
      f5_headers.each do |f5_line|
        f3_out.puts f3_entry if f3_line == f5_line
        f5_out.puts f5_entry if f5_line == f3_line
      end
    end
  end
end
