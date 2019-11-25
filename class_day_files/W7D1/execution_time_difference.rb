def my_min(list)
  min = nil
  list.each do |n1|
    # list2 = list[0...idx1] + list[idx1+1..-1]
    list2 = list.dup
    list2.delete(n1)
      min = n1 if list2.all? { |n| n1 < n }
  end
  min
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#  p  my_min(list)  # =>  -5
#Quadratic Time and space complexity



def my_min(list)
  min = list.first
  list.each do |num|
    min = num if num < min
  end
  min
end


# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#  p  my_min(list)  # =>  -5

 # Linear time -- constant space



def largest_contiguous_subsum(list)
  sub_arrays = []
  list.each_index do |i1|
    (i1...list.length).each do |i2|
      sub_arrays << list[i1..i2]
    end
  end
  sub_arrays.map! { |s_array| s_array.inject(:+) }
  sub_arrays.max
end

# list = [5, 3, -7]
# p largest_contiguous_subsum(list) # => 8

#     # possible sub-sums
#     [5]           # => 5
#     [5, 3]        # => 8 --> we want this one
#     [5, 3, -7]    # => 1
#     [3]           # => 3
#     [3, -7]       # => -4
#     [-7]          # => -7

def largest_contiguous_subsum(list)
 
  largest_sum = list.first
  cur_max = list.first
  list = list.drop(1)
 list.each do |num|
  cur_max = 0 if cur_max < 0
  cur_max += num
  
  largest_sum = cur_max if cur_max > largest_sum
 end
  
  largest_sum
end


list = [2, 3, -6, 7, -6, 7]
# cur = 2  5  0  7  1  8
# lar = 2  5  5   7  7  8
  p  largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

list = [5, 3, -7]
p largest_contiguous_subsum(list) # => 8

    # possible sub-sums
    [5]           # => 5
    [5, 3]        # => 8 --> we want this one
    [5, 3, -7]    # => 1
    [3]           # => 3
    [3, -7]       # => -4
    [-7]          # => -7


