class LinkedList

	require "./node"

	def initialize
		@head = nil
		@tail = nil
	end

	def append(node)
		# Scenario where the linked list is empty
		if (@head.nil?)
			@head = node
			@tail = node
		else
			@tail.next_node = node
			@tail = node
		end
	end

	def prepend(node)
		# Scenario where the linked list is empty
		if (@head.nil?)
			@head = node
			@tail = node
		else
			node.next_node = @head
			@head = node
		end
	end

	def size
		if (@head.nil?)
			return 0
		else
			curr = @head
			count = 1
			while (!curr.next_node.nil?)
				count += 1
				curr = curr.next_node
			end
			count
		end
	end

	def head
		if (@head.nil?)
			return "There is no head node."
		end
		@head
	end

	def tail
		if (@tail.nil?)
			return "There is no tail node."
		end
		@tail
	end

	def at(index)
		if (index == 0)
			return @head
		else
			curr = @head
			count = 0
			while (count != index)
				count += 1
				curr = curr.next_node
				if (curr.nil?)
					return "Index does not exist."
				end
			end
			curr
		end
	end

	def pop
		if (@head.nil?)
			return "List is empty, cannot pop any nodes."
		elsif (@head.next_node.nil?)
			@head = nil
			return "Node popped, list is now empty."
		else
			curr = @head
			# Check to see if the next node is the tail
			while (!curr.next_node.next_node.nil?)
				curr = curr.next_node
			end
			curr.next_node = nil
			@tail = curr
			"Last node popped, list is now of length #{self.size}."
		end
	end

	def contains?(value)
		if (@head.nil?)
			false
		else
			curr = @head
			while (!curr.nil?)
				if (curr.value == value)
					return true
				end
				curr = curr.next_node
			end
			false
		end
	end

	def find(data)
		if (@head.nil?)
			"List is empty."
		else
			curr = @head
			count = 0
			while (!curr.nil?)
				if (curr.value == data)
					return count
				end
				curr = curr.next_node
				count += 1
			end
			"Data not found."
		end
	end

	def to_s
		if (@head.nil?)
			"nil"
		else
			curr = @head
			while (!curr.nil?)
				print "#{curr.value} -> "
				curr = curr.next_node
			end
			print "nil"
		end
	end

	def insert_at(index, node)
		if (@head.nil?)
			"List is empty, index does not exist."
		else
			curr = @head
			count = 0
			while (!curr.nil?)
				# Find the node before the index we want to insert at
				if (count == index-1)
					# Case if we have only one node in the list
					if (count == 0)
						node.next_node = @head
						@head = node
					else
						# Save the pointer of the next node for our to be inserted node
						temp = curr.next_node
						# Set the current node to our new node
						curr.next_node = node
						# Set the new node's pointer to the one we saved
						node.next_node = temp
						# If we are inserting a new node beyond the tail
						if (node.next_node.nil?)
							@tail = node
						end
					end
					return "Node inserted at #{index}."
				end
				count += 1
				curr = curr.next_node
			end
			"Index does not exist."
		end
	end

	def remove_at(index)
		if (@head.nil?)
			"List is empty, index does not exist."
		elsif (index < 0 || index > self.size-1)
			"Index does not exist."
		else
			curr = @head
			count = 0
			# Case if we have only one node in the list and index is 0
			if (index == 0 && self.size == 1)
				@head = nil
				@tail = nil
				return "List is now empty."
			# Case if we're removing the head node and need to change it
			elsif (index == 0)
				@head = @head.next_node
				return "Node removed at #{index}."
			else
				while (!curr.nil?)
					# Find the node before the index we want to remove
					if (count == index-1)
						# Save the pointer of our removed node
						temp = curr.next_node.next_node
						# Set the current node before the removed node to the saved pointer
						curr.next_node = temp
						# Change the tail if the removed node was the last in the list
						if (temp.nil?)
							@tail = curr
						end
						return "Node removed at #{index}."
					end
					count += 1
					curr = curr.next_node
				end
			end
			"Error using remove at"
		end
	end
end