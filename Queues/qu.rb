
class LinkedListQueue
	attr_reader :size
	def initialize
		@last = nil
		@first = nil
		@size = 0
	end
	def enqueue(str)
		el = QueueElement.new
		el.val = str
		el.next = nil

		if (size==0) 
			@first = el
		else
			prev = @last
			prev.next = el
		end
		@last = el
		@size += 1
	end
	def dequeue
		el = @first
		@first = el.next
		el.val
	end

	class QueueElement
		attr_accessor :val, :next
	end
end

class ArrayQueue
	attr_reader :size
	def initialize
		@queue = Array.new(1,nil)
		@last = 0
		@first = 0
		@size = 0
	end
	def enqueue(str)
		if (@queue.size == @last)
			resize(2 * @queue.size)
		end
		@queue[@last] = str
		@last += 1
		@size += 1
	end
	def dequeue
		val = @queue[@first]
		@queue[@first] = nil
		@first += 1
		@size -= 1
		if (@queue.size-@first <= @queue.size/4)
			resize(@queue.size/2)
		end
		val
	end
	def resize(s)
		tmp = Array.new(s,nil)
		if s>=@queue.size
			@queue.each_with_index do |val,index|
				tmp[index] = @queue[index]
			end
		else
			i = 0
			while @queue[i]==nil
				i += 1
			end

			tmp.each_index do |index|
				tmp[index] = @queue[index+i]
			end
		end
		@queue = tmp
	end
end

#----------------------------------------
llq = LinkedListQueue.new
llq.enqueue('hello')
llq.enqueue('world')
puts llq.dequeue
puts llq.dequeue

arq = ArrayQueue.new
puts arq.size
arq.enqueue('one')
arq.enqueue('two')
arq.enqueue('three')
arq.enqueue('four')
arq.enqueue('five')
arq.enqueue('six')
arq.enqueue('seven')
puts arq.size
puts arq.dequeue
puts arq.dequeue
puts arq.dequeue
puts arq.dequeue
puts arq.dequeue
puts arq.dequeue