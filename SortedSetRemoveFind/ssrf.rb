# Remove element and find sucessor on sorted set
# Using binary search

class SortedSet
  attr_reader :set
  def initialize(n)
    @set = Array.new(n)#.fill(0){|i| i}
    prev = 0
    @set.map! do
      prev += rand(5)+1
    end
  end
  def remove(x)
    bottom = 0
    top = @set.size-1
    while top>=bottom
      id = (top + bottom) / 2
      #puts "t=#{top}, b=#{bottom}, id=#{id}"
      if @set[id] == x
        @set.delete_at(id)
        return true
      elsif x<@set[id]
        top = id-1
      else
        bottom = id+1
      end
    end
    return false
  end
  def successor(x)
    bottom = 0
    top = @set.size-1
    while top>=bottom
      id = (top + bottom) / 2
      #puts "t=#{top}, b=#{bottom}, id=#{id}"
      if @set[id] == x
        return @set[id+1]
      elsif x<@set[id]
        top = id-1
      else
        bottom = id+1
      end
    end
    return @set[top+1] if (top+1)<@set.size
    return false
  end
end

#---------------------------------------------

ss = SortedSet.new(10)

inp = ''
while inp!='q'
  puts "Insert command (rem N / succ N / show / q)"
  print "> "
  inp = gets.chomp
  command, id = inp.split(' ')
  case command
  when 'rem'
    then puts ss.remove(id.to_i)
  when 'succ'
    then puts ss.successor(id.to_i)
  when 'show'
    then p ss.set
  end
end
