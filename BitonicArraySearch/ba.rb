# Bitonic Array Search

class BitonicArray
  attr_reader :array
  def initialize(n)
    return false if n<5
    @array = Array.new(n,0)
    mid = 2 + rand(n - 4)
    prev = 0
    for i in (0..mid)
      begin
        prev += rand(5)
      end while @array.include?(prev)
      @array[i] = prev
    end
    for i in (mid + 1..n - 1)
      begin
        prev -= rand(5)
      end while @array.include?(prev)
      @array[i] = prev
    end
  end
  def search(x)
    # 2-loop binary search (fail)
    bottom_1 = 0
    top_1 = @array.size-1
    mid_1 = (top_1 + bottom_1) / 2
    while top_1 >= bottom_1
      id = (top_1 + bottom_1) / 2
      if @array[id] == x
        return id
      elsif x > @array[id]
        bottom_1 = id + 1
      else
        top_1 = id - 1
      end
    end

    bottom_2 = mid_1 + 1
    top_2 = @array.size-1
    while top_2 >= bottom_2
      id = (top_2 + bottom_2) / 2
      if @array[id] == x
        return id
      elsif x > @array[id]
        top_1 = id - 1
      else
        bottom_1 = id + 1
      end
    end
  end
  def middle
    bottom = 0
    top = @array.size-1
    while top>bottom
      first = (2*bottom+top)/3
      second = (bottom+2*top)/3
      #puts "bottom=#{bottom}, first=#{first}, second=#{second}, top=#{top}"
      if first==second
        if @array[top]>@array[bottom]
          return top
        else
          return bottom
        end
      elsif @array[first]<@array[second]
        bottom = first+1
      else
        top = second-1
      end
      #puts "bottom=#{bottom}, first=#{first}, second=#{second}, top=#{top}"
    end
  end
end

#-------------------------------------

ba = BitonicArray.new(10)

inp = ''
while inp!='q'
  puts "Insert command (s N / show / q)"
  print "> "
  inp = gets.chomp
  command, id = inp.split(' ')
  case command
  when 's'
    then p ba.search(id.to_i)
  when 'show'
    then p ba.array
  when 'mid'
    then p ba.middle
  end
end
