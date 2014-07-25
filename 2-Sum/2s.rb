# 2-Sum Algorithm

class TwoSum
  attr_reader :set
  def initialize(n)
    @set = Array.new(n)
    prev = 0
    @set.map!{rand(5)*(rand > 0.5 ? -1 : 1)}
  end
  def sort
    # assume it takes N**2 OofG
    @set.sort!
  end
  def bsearch(x)
    # has logN OofG
    bottom = 0
    top = @set.size-1
    while top>=bottom
      id = (bottom + top) / 2
      if @set[id]==x
        return id
      elsif x>@set[id]
        bottom = id + 1
      else
        top = id - 1
      end
    end
    return false
  end
  def process
    # has N**2 OofG
    res = []
    for i in (0..@set.size-1)
      for j in (i+1..@set.size-1)
        si = @set[i]
        sj = @set[j]
        res << [si,sj].sort if si+sj==0 && si!=0
      end
    end
    res.uniq
  end
  def bsearch_process
    # has N*logN
    # set must be sorted
    res = []
    for i in (0..@set.size-1)
      si = @set[i]
      sj_id = bsearch(-1*si)
      res << [si,@set[sj_id]].sort if sj_id!=false && si!=0
    end
    res.uniq
  end
end

#-------------------------------------

ts = TwoSum.new(10)
p ts.set
p ts.process
ts.sort
p ts.set
p ts.bsearch_process
