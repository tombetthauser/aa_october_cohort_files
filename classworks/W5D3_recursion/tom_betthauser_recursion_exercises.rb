require "byebug"

def range(start, last)
  if last <= start
    return []
  end
  range(start, last-1) + [last-1]
end

# p range(1, 5)
# p range(1, 1)
# p range(1, 0)


def recursive_sum(array)
  if array.length == 0
    return 0
  end
  recursive_sum(array[1..-1]) + array.first
end

# array = [1,2,3,4,5]
# p recursive_sum(array)


def iterative_sum(array)
  sum = 0
  array.each do |ele|
    sum += ele
  end
  sum
end

# array = [1,2,3,4,5]
# p iterative_sum(array)


def exponent_v1(b, n)
  puts s += 1
  if n == 0
    return 1
  end
  b * exponent_v1(b, n-1)
end

# p exponent_v1(2, 256)
# p exponent_v1(2, 0)

def exponent_v2(b, n)
  puts s += 1
  if n == 0 
    return 1
  elsif n == 1 
    return b
  elsif n.even?
    rec = exponent_v2(b, n / 2)
    rec * rec
  else 
    rec = exponent_v2(b, (n - 1) / 2)
    b * rec * rec
  end
end

# p exponent_v2(2,256)

class Array

  def deep_dup
    dup = []
    self.each do |ele|
      if ele.is_a?(Array)
        dup << ele.deep_dup
      else
        dup << ele
      end
    end
    dup
  end
end

robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

# robot_parts_copy = robot_parts.deep_dup

# shouldn't modify robot_parts
# p robot_parts_copy[1] << "LEDs"
# but it does
# p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]



def fib(n)
  if n <= 2
    return [0, 1].take(n)
  end
  previous_fib = fib(n-1)
  next_ele = previous_fib[-1] + previous_fib[-2]
  previous_fib << next_ele
end

# p fib(5)
# p fib(10)

def bsearch(array, target)
  mid_idx = array.length / 2
  if array[mid_idx] == target
    mid_idx
  elsif array.length == 1
    nil
  elsif array[mid_idx] > target
    bsearch(array[0...mid_idx], target)
  elsif array[mid_idx] < target
    after_mid_idx = mid_idx + 1
    recursion = bsearch(array[after_mid_idx..-1], target)
    recursion.nil? ? nil : after_mid_idx + recursion
  end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil



def merge_sort(array)
  if array.length < 2
    return array
  end
  first_half = array[0...array.length / 2]
  second_half = array[array.length / 2..-1]

  merge(merge_sort(first_half), merge_sort(second_half))
end

def merge(arr_1, arr_2)
  merged = []
  
  until arr_1.empty? && arr_2.empty?
    if arr_1.empty?
      merged << arr_2.shift
    elsif arr_2.empty?
      merged << arr_1.shift
    elsif arr_2[0] < arr_1[0]
      merged << arr_2.shift
    elsif arr_1[0] < arr_2[0]
      merged << arr_1.shift
    else
      merged << arr_1.shift
      merged << arr_2.shift
    end
  end
  merged
end

def subsets(array)
  return [[]] if array.empty?

  all_subsets = []
  last_ele = array.pop
  subsets_without_last_ele = subsets(array)

  subsets_without_last_ele.each.with_index do |subset, i|
    all_subsets << subset
    new_subset = subset.dup << last_ele
    all_subsets << new_subset
  end
  all_subsets
end

# if array.length == 1
  #   subs << array
  #   return subs
  # end

  # subs << subsets(array[1...-1]) + array[0]
  # subs << array[0] + subsets(array[1...-1])

# oh hell yeah ~
# :)
# looks super clean too


