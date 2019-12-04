# Exercise 1 - Stack

# Let's write a Stack class. To do this, use the following
#  framework:


class Stack
    def initialize
      # create ivar to store stack here!
      @ivar = []
    end

    def push(el)
      # adds an element to the stack
      @ivar << []
    end

    def pop
      # removes one element from the stack
      @ivar = @ivar[0...@ivar.length]
    end

    def peek
      # returns, but doesn't remove, the top element in the stack
      @ivar[@ivar.length - 1]
    end
  end


  # To test that your code works, create a new instance of the Stack
  #  class, and play around with adding and removing elements. Remember,
    #  a stack follows the principle of LIFO!








#     Exercise 2 - Queue

# Now let's write a Queue class. We will need the following instance methods: 
# enqueue(el), dequeue, and peek.

# Test your code to ensure it follows the principle of FIFO.


class Queue

  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.unshift(el)
  end

  def dequeue
    @queue.pop
  end

  def peek
    @queue.last
  end

end






# Exercise 3 - Map

# As you saw in the videos for tonight, a map can be implemented using a 2D 
# array. Let's write a Map class (following a similar pattern to Stack and 
# Queue) that implements a map using only arrays.

# Remember, a map stores information in key-value pairs, where the keys are always
#  unique. When implemented with arrays, a map might look something like this:
#  my_map = [[k1, v1], [k2, v2], [k3, v2], ...].

# Our Map class should have the following instance methods: set(key, value),
#  get(key), delete(key), show. Note that the set method can be used to either 
# create a new key-value pair or update the value for a pre-existing key. It's 
# up to you to check whether a key currently exists!

# As always, test your code thoroughly to make sure all properties of maps are enforced.



class Map

  def initialize
    @map = []
  end

  def set(key, val)
    # set new
    # or update existing
    @map.each_with_index do |pair, map_idx|
      if pair.first == key
        @map[map_idx][0] = val
        return true
      end
    end
    @map << [key, val]; true
  end

  def get(key)
    @map.each_with_index do |pair, map_idx|
      if pair.first == key
        return pair.last
      end
    end
    nil
  end

  def delete(key)
    @map.each_with_index do |pair, map_idx|
      if pair.first == key
        @map = @map[0...map_idx] + @map[map_idx + 1...@map.length]
        return true
      end
    end
    false
  end

  def show
    @map
  end
end