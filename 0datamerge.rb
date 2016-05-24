
#
# data merge program, making integrated output from separated files
#   by Teruaki Yokoyama
#
#  v0.1 : 2016/05/23
#
# ruby 0datamerge.rb DIRs LOC_IDs
# ruby 0datamerge.rb "log1/log log2/log log3/log log5/log log6/log log7/log log4/log" "1F 2F 3F 5F 6F 7F 8F"
#
# Example input and output:
#  1463535468.957761,349dcdc57805dc5856b4ec9b6f2ffa11f1849b9e,757,584822,-221,mobilepoint
#  1463986497.126842,8F,05c47c22990175a971aa442fe2260a09934313bd,176,1bc7,-215,default
#

dirs = ARGV[0].split(" ")
#p dirs
locs = ARGV[1].split(" ")
#p locs

i = 0
dirs.each do |dir|
  files = Dir.glob(dir+"/*.txt").sort
#  p locs[i]
#  p files.size

  files.each do |file|
    f = open(file, "r")
    while (line = f.gets) do
      begin
        data = line.split(",")
      rescue
        next
        exit
      end
      next if (data.size != 6)
      output = sprintf("%s,%s,%s,%s,%s,%s,%s",
        data[0],
        locs[i],
        data[1],
        data[2],
        data[3],
        data[4],
        data[5]
      )
      puts(output)
    end
    f.close()
  end

  i += 1
end

