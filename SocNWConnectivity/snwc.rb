# Social Network Connectivity

require "#{File.dirname(__FILE__)}/../WeightedQuickUnion/wqu.rb"

class Connectivity
  def initialize(log_file)
    @log_file = log_file
    @ids={}
    @sizes={}
  end
  def find_time
    File.open(@log_file,'r') do |file|
      file.each_line do |line|
        ts, name_1, name_2 = line.chomp.split(';')
        if !@ids.include? name_1 then
          @ids[name_1] = name_1
          @sizes[name_1] = 1
        end
        if !@ids.include? name_2 then
          @ids[name_2] = name_2
          @sizes[name_2] = 1
        end
        union(name_1,name_2)
        if connected? then
          puts "Connected at #{ts} with #{@ids.size} IDs"
          #gets
        else
        end
      end
    end
  end

  def root(id)
    while id!=@ids[id] do
      #@ids[id]=@ids[@ids[id]]
      #@ids.store(id,@ids[@ids[id]])
      id = @ids[id]
    end
    id
  end

  def union(id1, id2)
    i = root(id1)
    j = root(id2)
    return false if i==j
    if @sizes[i]<@sizes[j]
      @ids[i] = j
      @sizes[j] += @sizes[i]
    else
      @ids[j] = i
      @sizes[i] += @sizes[j]
    end
    return true
    #puts "IDS = #@ids"
    #puts "S = #@sizes"
  end

  def connected?
    first_root = root(@ids.fetch(*@ids.first))
    #puts "First root = #{first_root}"
    @ids.each_key do |id|
      return false if root(id)!=first_root
    end
    return true
  end
end

#----------------------------------------------

c = Connectivity.new(File.expand_path(File.dirname(__FILE__))+'/log.txt')
c.find_time
