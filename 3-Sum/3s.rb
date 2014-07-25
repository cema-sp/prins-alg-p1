# 3-Sum Algorithm

class ThreeSum
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
    # takes N**3 OofG
    res = []
    for i in (0..@set.size-1)
      for j in (i+1..@set.size-1)
        for k in (j+1..@set.size-1)
          si = @set[i]
          sj = @set[j]
          sk = @set[k]
          res << [si,sj,sk].sort if si+sj+sk==0 && [si,sj,sk].count(0)<2
        end
      end
    end
    res.uniq
  end
  def bsearch_process
    # has N**2*logN
    # set must be sorted
    res = []
    for i in (0..@set.size-1)
      for j in (i+1..@set.size-1)
        si = @set[i]
        sj = @set[j]
        sk_id = bsearch(-1*(si+sj))
        res << [si,sj,@set[sk_id]].sort if sk_id!=false &&
                            [si,sj,@set[sk_id]].count(0)<2 &&
                            sk_id!=i && sk_id!=j
      end
    end
    res.uniq
  end
end

#-------------------------------------

ts = ThreeSum.new(10)
p ts.set
p ts.process
ts.sort
p ts.set
p ts.bsearch_process
