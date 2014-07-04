# Quick Find Algorithm

class QuickFindUF
	attr_reader :id
	def initialize(n)
		@id = Array.new(n).fill(0) {|i| i}
	end
	def connected?(p,q)
		@id[p]==@id[q]
	end
	def union(p,q)
		@id = @id.map{|id| id==@id[p] ? @id[q] : id }
	end
end

#----------------------------------------------------
=begin	test
qf = QuickFindUF.new(10)
qf.union(1,2)
qf.union(2,3)

p qf.id
=end