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
  def search2(x)
    # OofG = 3log(N base 2)
    top = @array.size - 1
    bottom = 0

    while top>bottom
      mid = (bottom+top)/2
      value_mid = @array[mid]
      value_mid_next = @array[mid+1]
      if x==value_mid
        return mid
      elsif x>value_mid
        if value_mid>value_mid_next
          top = mid-1
        else
          bottom = mid+1
        end
      else
        bottom_1 = bottom
        top_1 = mid-1

        while top_1>=bottom_1
          mid_1 = (top_1+bottom_1)/2
          val_1 = @array[mid_1]
          if x==val_1
            return mid_1
          elsif x<val_1
            top_1 = mid_1-1
          else
            bottom_1 = mid_1+1
          end
        end

        bottom_2 = mid+1
        top_2 = top

        while top_2>=bottom_2
          mid_2 = (top_2+bottom_2)/2
          val_2 = @array[mid_2]
          if x==val_2
            return mid_2
          elsif x>val_2
            top_2 = mid_2-1
          else
            bottom_2 = mid_2+1
          end
        end
      end
    end
  end
  def search3(x)
    # 2-loop binary search
    # OofG = 2log(N base 2)
    max = self.index_max

    top = max
    bottom = 0

    while top>=bottom
      mid = (top+bottom)/2
      val = @array[mid]
      if x>val
        bottom = mid+1
      elsif x<val
        top = mid-1
      else
        return mid
      end
    end

    top = @array.size-1
    bottom = max+1

    while top>=bottom
      mid = (top+bottom)/2
      val = @array[mid]
      if x<val
        bottom = mid+1
      elsif x>val
        top = mid-1
      else
        return mid
      end
    end

    return nil
  end
  def index_max
    # index of middle element
    # OofG = log(N)
    top = @array.size - 1
    bottom = 0

    while top>bottom
      mid = (bottom+top)/2
      if @array[mid]>=@array[mid+1]
        top = mid
      else
        bottom = mid+1
      end
    end
    top
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
    then p ba.search2(id.to_i)
  when 'show'
    then p ba.array
  end
end
