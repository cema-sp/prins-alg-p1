# Percolation
require "#{File.dirname(__FILE__)}/../QuickFind/qf.rb"


class Percolation
	def initialize(n)
		@dimension = n
		@states = Array.new(n*n).fill(0)
		@uf = QuickFindUF.new(n*n+2)
		(1..@dimension).each {|i| @uf.union(i,0)}
		((n*n+1-@dimension)..(n*n+1)).each {|i| @uf.union(i,n*n+1)}
	end
	def open(i,j)
	
	end
	def is_open?(i,j)
	
	end
	def is_full?(i,j)
	
	end
	def percolates?
	
	end
	def show
		j = 0
		# top ruler
		(0...@dimension).each {|i| print " #{i%10}"}
		print "\n"
		@states.map{|s| s==0 ? "\u2588" : "\u2591"}
			.each_slice(@dimension) do |slice| 
				# left ruler
				print j%10
				slice.each {|s| print s*2}
				print "\n"
				j+=1
			end
	end
	def show_uf
		p @uf.id
	end
end

#---------------------------------------------

p = Percolation.new(5)
p.show
p.show_uf