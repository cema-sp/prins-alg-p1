# Percolation
require "#{File.dirname(__FILE__)}/../QuickFind/qf.rb"
require "#{File.dirname(__FILE__)}/../QuickUnion/qu.rb"
require "#{File.dirname(__FILE__)}/../WeightedQuickUnion/wqu.rb"

# class for percolation algorithm
class Percolation
	def initialize(n, class_name='QuickFindUF')
		@dimension = n
		@states = Array.new(n*n).fill(0)
		@top = 0
		@bottom = n*n+1
		@uf = Object.const_get(class_name).new(n*n+2)
		(1..@dimension).each {|i| @uf.union(i,@top)}
		((@bottom-@dimension)..(@bottom)).each {|i| @uf.union(i,@bottom)}
	end
	def open(i,j)
		n = i*@dimension+j
		open_(n)
	end
	def open_(n)
		# connect with upper
		upper = n - @dimension
		@uf.union(upper+1, n+1) if upper>=0 && is_open_?(upper)
		# connect with right
		right = n + 1
		@uf.union(right+1, n+1) if right<@dimension*@dimension && is_open_?(right)
		# connect with left
		left = n - 1
		@uf.union(left+1, n+1) if left>=0 && is_open_?(left)
		# connect with bottom
		bottom = n + @dimension
		@uf.union(bottom+1, n+1) if bottom<@dimension*@dimension && is_open_?(bottom)

		@states[n] = is_full_?(n) ? 2 : 1
	end
	def is_open?(i,j)
		n = i*@dimension+j
		is_open_?(n)
	end
	def is_open_?(n)
		@states[n] >= 1
	end
	def is_full?(i,j)
		n = i*@dimension+j
		is_full_?(n)
	end
	def is_full_?(n)
		@uf.connected?(@top,n+1)
	end
	def percolates?
		@uf.connected?(@top,@bottom)
	end
	def count_open
		@states.count {|s| s>=1}
	end
	def count
		@states.count
	end
	def show
		j = 0
		# top ruler
		(0...@dimension).each {|i| print " #{i%10}"}
		print "\n"
		@states.map{|s| s==0 ? "\u2588" : (s == 1 ? "\u2591" : "\u2592")}
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

# class for Monte Carlo method for percolation
class PercolationStats
	def initialize(num, size)
		@num, @size = num, size
		@results = Array.new(@num,0)
	end
	def mean
		@results.reduce(0,:+)/@results.size
	end
	def stddev
		m = mean
		@results.reduce(0) {|sum, r| sum+(r-m)**2} / (@results.size-1)
	end
	def confidenceLo
		mean - (1.96*stddev/@results.size*0.5)
	end
	def confidenceHi
		mean + (1.96*stddev/@results.size*0.5)
	end
	def run
		@time_b = Time.now
		@num.times do |n|
			p = Percolation.new(@size,'WeightedQUUF')
			begin
				i = rand(@size)
				j = rand(@size)
				p.open(i,j)
			end until p.percolates?
			@results[n] = p.count_open.to_f/p.count
			#p "@results[#{i}] = #{@results[i]}"
		end
		@time_e = Time.now
	end
	def show
		puts "-"*50
		puts "mean \t\t\t= #{mean}"
		puts "std deviation \t\t= #{stddev}"
		puts "95% conf interval \t= #{confidenceLo}, #{confidenceHi}"
		puts "time \t\t\t= #{@time_e-@time_b} s"
		puts "-"*50
	end

end
#---------------------------------------------

begin
	print "Insert field dimension: "
	size = gets.chomp.to_i
	print "Insert experiments count: "
	num = gets.chomp.to_i

	ps = PercolationStats.new(num.to_i, size.to_i)
	ps.run
	ps.show

	print "q - quit: "
	ins = gets.chomp
end while ins != "q"
