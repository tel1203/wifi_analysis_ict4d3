
#
# ruby 1filter_date.rb YYYY/MM/DD hh:mm:ss [YYYY/MM/DD hh:mm:ss]
#
# Ex:
# ruby 1filter_date.rb 2016/05/18 0:0:0 2016/05/18 23:59:59

require 'time'

if (ARGV.size <= 2) then
  strdate0 = ARGV.join(" ")
  strdate1 = "2099/12/31 23:59:59"
elsif (ARGV.size <= 4) then
  strdate0 = ARGV[0,2].join(" ")
  strdate1 = ARGV[2,2].join(" ")
end

date0 = Time.parse(strdate0).to_i
date1 = Time.parse(strdate1).to_i

#p date0
#p date1

while (line = STDIN.gets) do
#  begin
    data = line.split(",")
    if ((data[0].to_f >= date0) and (data[0].to_f <= date1)) then
      puts(line)
    end
#  rescue
#    next
#  end

end

