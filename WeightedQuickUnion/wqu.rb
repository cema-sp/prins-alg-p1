# Weighted Quick Union Algorithm

class WeightedQUUF
	attr_reader :id
	def initialize(n)
		@id = Array.new(n).fill(0) {|i| i}
		@sz = Array.new(n,1)
	end
	def root(p)
		while(p!=@id[p]) do
			@id[p] = @id[@id[p]]
			p = @id[p]
		end
		p
	end
	def connected?(p,q)
		root(p)==root(q)
	end
	def union(p,q)
		i = root(p)
		j = root(q)
		return if i==j
		if @sz[i]<@sz[j]
			@id[i] = j
			@sz[j] += @sz[i]
		else
			@id[j] = i
			@sz[i] += @sz[j]
		end
	end
end


#----------------------------------------------------
=begin 	test
qf = WeightedQUUF.new(10)
qf.union(1,2)
qf.union(2,3)

p qf.id
=end