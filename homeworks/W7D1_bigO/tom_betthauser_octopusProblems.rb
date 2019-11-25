# Big O-ctopus and Biggest Fish

# A Very Hungry Octopus wants to eat the longest fish in an array of fish.

fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# => "fiiiissshhhhhh"

# Sluggish Octopus

# Find the longest fish in O(n^2) time. Do this by comparing all fish lengths to all other fish lengths
# Dominant Octopus

class Array
  
  def sluggish
    elements = self.count
    count = 0

    system "clear"
    print "elements = #{self.length}\n"
    
    (0...self.length).each do |idx1|
      longest = true
      
      (0...self.length).each do |idx2|
        count += 1
        unless idx1 == idx2
          longest = false if self[idx1].length < self[idx2].length
        end
      end
      
      if longest == true
        print "elements = #{count}\n\n"
        return self[idx1] 
      end
    end
  end

end

# p fish.sluggish







# Find the longest fish in O(n log n) time. Hint: You saw a sorting algorithm 
# that runs in O(n log n) in the Sorting Complexity Demo. Remember that Big O 
# is classified by the dominant term.
# Clever Octopus

class Array

  def merge_sort(&prc)
    prc ||= Proc.new { |a,s| a <=> s }

    return self if self.length < 2

    mid = self.length / 2
    left = self[0...mid].merge_sort(&prc)
    right = self[mid..-1].merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  def self.merge(left, right, &prc)
    sorted = []

    until left.empty? || right.empty?
      if prc.call(left.first, right.first) == -1
        sorted << left.shift
      else
        sorted << right.shift
      end
    end

    sorted + left + right
  end

  def clever
    self.merge_sort { |a, b| a.length <=> b.length }.last
  end

end

# p fish.clever





# Find the longest fish in O(n) time. The octopus can hold on to the longest 
# fish that you have found so far while stepping through the array only once.
# Dancing Octopus

class Array

  def dancing
    longest = self[0]
    (1...self.length).each do |idx|
      longest = self[idx] if self[idx].length > longest.length
    end
    longest
  end

end

# p fish.dancing




# Full of fish, the Octopus attempts Dance Dance Revolution. The game has tiles in the following directions:

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

# To play the game, the octopus must step on a tile with her corresponding tentacle. 
# We can assume that the octopus's eight tentacles are numbered and correspond to the tile direction indices.

# Slow Dance

# Given a tile direction, iterate through a tiles array to return the tentacle number 
# (tile index) the octopus must move. This should take O(n) time.

def slow_dance(dir, arr)
  (0...arr.length).each do |idx|
    return idx if arr[idx] == dir
  end
end

# p slow_dance("up", tiles_array)
# # > 0

# p slow_dance("right-down", tiles_array)
# > 3





# Constant Dance!

# Now that the octopus is warmed up, let's help her dance faster. Use a different 
# data structure and write a new function so that you can access the tentacle number in O(1) time.

dir_hash = { "up" => 0, "right-up" => 1, "right"=> 2, "right-down" => 3, "down" => 4, "left-down" => 5, "left" => 6, "left-up" => 7 }

def fast_dance(dir, hash)
  hash[dir]
end

p fast_dance("up", dir_hash)
# > 0

p fast_dance("right-down", dir_hash)
# > 3




# Did you find this lesson helpful?
# No
