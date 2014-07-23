# LOG file generator
# ARGV[0] - log lines count

names = %w[Pit Bob Sally Jessey Wolter Irina Rust Jack
           Jessica Irvin Said]


log_file = File.expand_path(File.dirname(__FILE__))+'/log.txt'
log_lines = ARGV[0].to_i||20

#--------------------------------------------------
File.open(log_file,'w+') do |file|
  while log_lines > 0 do
    tmp_t = Time.now.to_a
    time_dif = tmp_t[2]-log_lines
    tmp_t[2] = time_dif % 24
    tmp_t[3] = tmp_t[3]+time_dif/24 if time_dif<0
    log_lines-=1

    name_1 = names[rand(names.size)]
    name_2 = name_1
    while name_1==name_2 do
      name_2 = names[rand(names.size)]
    end

    puts Time.local(*tmp_t).to_s+';'+name_1+';'+name_2
    file.puts Time.local(*tmp_t).to_s+';'+name_1+';'+name_2
  end
end
