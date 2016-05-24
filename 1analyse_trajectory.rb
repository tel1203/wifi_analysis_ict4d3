#
# $ ruby 1analyse_count_devid_time.rb 20150427_1100-1300.txt 900 
# $ ruby 1analyse_count_devid_time.rb 20150427_1600-1800.txt 900
#
file = ARGV[0]
period = ARGV[1].to_i
# output format: screen/csv
if (ARGV[2] != nil) then
  format = ARGV[2]
else
  format = "screen"
end
#

##########
f = open(file, "r")
time = f.gets.split(",")[0]
f.close

date = Time.at(time.to_f)
date0 = Time.local(date.year, date.month, date.day)
diff = date - date0
n0 = (diff.to_i / period).to_i

date_next = (date0 + (n0+1)*period).to_f


##########
track = Hash.new
output = Hash.new
header = Array.new
timeslot = 0
strformat = "%Y/%m/%d %H:%M:%S"

f = open(file, "r")
while (line = f.gets) do
  # ["1430094697.12594", "D", "9f7f5131af70e66bcf5f11466ff980b62c087b73", "2", "54724f", "-212", "BROADCAST"]
  data = line.chop.split(",")

  if ((data[0].to_f >= date_next) or (f.eof == true)) then
    header.push(sprintf("%s\n", Time.at(date_next).strftime(strformat)))

    track.keys.sort.each do |key|
#      printf("%s :", key)

      count = Hash.new(0)
      track[key].each do |loc|
         count[loc] += 1
      end
      tmp = count.to_a.sort do |x,y| y[1] <=> x[1] end
#      printf("%s\n", tmp[0][0])

      output[key] = Array.new if (output[key] == nil)
      output[key][timeslot] = tmp[0][0]
    end

    track = Hash.new
    date_next  += period.to_f
    timeslot += 1
  end

  # Analysis
  track[data[2]] = Array.new if (track[data[2]] == nil)
  track[data[2]].push(data[1])

end
f.close

if (format == "csv") then
  for i in 0..timeslot do
    printf(",%d", i)
  end
  puts
end

output.each_pair do |key, data|
  if (format == "screen") then
    printf("%s: ", key[0,10])
    data.each do |loc|
      if (loc == nil) then 
        printf(" ")
      else
        printf("%s", loc)
      end
    end
    puts
  elsif (format == "track") then
    printf("%s\n", data.to_s)
  elsif (format == "csv") then
    printf("%s,%s\n", "'"+key[0,10], data.join(","))
  end
  
end


