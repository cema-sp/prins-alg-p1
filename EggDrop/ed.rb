# Eggs Drop

class EggsDrop
  def initialize(h,l)
    @height, @level = h, l
  end
  def toss(h)
    @tosses += 1
    if h<@level
      true
    else
      @eggs += 1
      false
    end
  end
  def reset_stats
    @eggs, @tosses = 0, 0
  end
  def print_inputs
    puts "Given: #@height -floor building with level = #@level"
  end
  def print_result(alg, res)
    puts "\n#{alg} done with #@eggs eggs and #@tosses tosses. Found level = #{res}"
  end
  def alg_1
    # OofG(eggs) = 1
    # OofG(tosses) = L
    reset_stats

    res = 0
    found = false
    while !found
      res += 1
      if !toss(res)
        found = true
      end
    end

    print_result("Alg_1", res)
  end
  def alg_2
    # OofG(eggs) = log_2(H)
    # OofG(tosses) = log_2(H)
    reset_stats

    bottom = 1
    top = @height
    while top>bottom
      res = (bottom+top)/2
      if toss(res)
        bottom = res+1
      else
        top = res
      end
    end
    res = (bottom+top)/2

    print_result("Alg_2", res)
  end
  def alg_3
    # OofG(eggs) = 2
    # OofG(tosses) = 2sqrt(H)
    reset_stats

    step = (@height**(0.5)).to_i
    current = step

    while current<=@height
      break if !toss(current)
      current += step
    end

    found = false
    res = current - step
    while !found
      res += 1
      if !toss(res)
        found = true
      end
    end

    print_result("Alg_3", res)
  end
  def alg_4
    # OofG(eggs) = 2
    # OofG(tosses) = 
    reset_stats

    step = (((8*@height+1)**(0.5)-1)/2).ceil
    current = step

    while current<@height
      break if !toss(current)
      step -= 1
      current += step
    end

    found = false
    res = current - step
    while !found
      res += 1
      if !toss(res)
        found = true
      end
    end

    print_result("Alg_4", res)
  end
end

#---------------------------------------------------------

ed = EggsDrop.new(100,99)
ed.print_inputs
ed.alg_1
ed.alg_2
ed.alg_3
ed.alg_4