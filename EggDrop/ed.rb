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
    puts "\n#{alg} done with #@eggs eggs and #@tosses tosses. Level = #{res}"
  end
  def alg_1
    # algorithm with l OofG
    reset_stats

    h = 0
    found = false
    while !found
      h += 1
      if !toss(h)
        found = true
      end
    end

    print_result("Alg_1", h)
  end
  def alg_2
    # algorithm with l OofG
    reset_stats

    bottom = 1
    top = @height
    while top>=bottom
      h = (bottom+top)/2
      if toss(h)
        bottom = h+1
      else
        top = h-1
      end
    end

    print_result("Alg_2", h)
  end
end

#---------------------------------------------------------

ed = EggsDrop.new(100,45)
ed.print_inputs
ed.alg_1
ed.alg_2
