# system "clear"
# loop do
#   a = (-10..10).to_a.sample
#   b = (-10..10).to_a.sample
#   print "\n\n\n#{a} % #{b} = "

#   b == 0 ? correct = "error" : correct = a % b

#   input = gets.chomp.downcase
#   input = input.to_i unless input.downcase == "error" 

#   print "\nCorrect answer was #{correct}, "
#   if input == correct 
#     print "good job!"
#   else
#     print "try again!"
#   end

#   print "\n\n"
#   25.times { print "_" }
# end


# require "byebug"

# class Array
  
#   def my_zip

#   end

#   def my_rotate(times = 1)
#     debugger
#     mod_idx = times % self.length
#     self[mod_idx..-1] + self[0...mod_idx]
#   end
  
# end


# a = [1,2,3]
# b = ["a", "b", "c"]
# c = ["cat"]

# # p a.zip(b)      # => [[1, "a"], [2, "b"], [3, "c"]]
# # p a.zip(b,c)    # => [[1, "a", "cat"], [2, "b", nil], [3, "c", nil]]
# # p b.zip(a)      # => [["a", 1], ["b", 2], ["c", 3]]
# # p c.zip(b)      # => [["cat", "a"]]

# p a.my_rotate        # => [2, 3, 1]
# p a.my_rotate(-2)    # => [2, 3, 1]
# p a.my_rotate(236)   # => [3, 1, 2]
# p a.my_rotate(-752)  # => [2, 3, 1]





def qsort(arr)
  return arr if arr.length < 2

  pivot = arr[0]
  left = arr[1..-1].select { |ele| ele <= pivot }
  right = arr[1..-1].select { |ele| ele > pivot }

  qsort(left) + [pivot] + qsort(right)
end

p a = (1..10).to_a.shuffle
p qsort(a)