# Quick Union Algorithm

class QuickUnionUF
	attr_reader :id
	def initialize(n)
		@id = Array.new(n).fill(0) {|i| i}
	end
	def root(p)
		while(p!=@id[p]) do; p = @id[p]; end
		p
	end
	def connected?(p,q)
		root(p)==root(q)
	end
	def union(p,q)
		@id[root(p)]=root(q)
	end
end

#----------------------------------------------------
=begin test
qf = QuickUnionUF.new(10)
qf.union(1,2)
qf.union(2,3)

p qf.id
=end