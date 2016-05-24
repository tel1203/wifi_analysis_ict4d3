
#
# ruby 1filter_rssi.rb RSSI
#   RSSI indicates a strength of WiFi signal
#
# Ex: only shows records which RSSI over -200
# ruby 1filter_rssi.rb -200

rssi = ARGV[0].to_i

while (line = STDIN.gets) do
#  begin
    data = line.split(",")
    if (data[5].to_i >= rssi) then
      puts(line)
    end
#  rescue
#    next
#  end

end

