
class LinkedListStack
	attr_reader :size
	def initialize
		@top = nil
		@size = 0
	end
	def push(str)
		el = StackElement.new
		el.val = str
		el.prev = @top
		@top = el
		@size += 1
	end
	def pop
		el = @top
		@top = el.prev
		@size -= 1
		el.val
	end
	def empty?
		return (@top==nil)
	end

	class StackElement
		attr_accessor :val, :prev
	end
end

class ArrayStack
	attr_reader :size
	def initialize
		@stack = Array.new(1,nil)
		@cursor = 0
		@size = 0
	end
	def push(str)
		if (@cursor==@stack.size) 
			resize(2 * @stack.size)
		end
		@stack[@cursor] = str
		@cursor += 1
	end
	def pop
		@cursor -= 1
		val = @stack[@cursor]
		@stack[@cursor] = nil
		if (@cursor > 0)&&(@cursor == @stack.size/4)
			resize(@stack.size/2)
		end
		return val
	end
	def resize(s)
		tmp = Array.new(s,nil)
		@stack.each_with_index do |val,index|
			tmp[index] = val
		end
		@stack = tmp
	end
end
#---------------------------------------------------
lls = LinkedListStack.new
lls.push('hello')
lls.push('world')
puts lls.pop, lls.pop

ars = ArrayStack.new
ars.push('hello')
ars.push('world')
puts ars.pop, ars.pop
