require 'byebug'
class Array

  def my_inject(acc = nil, &prc)
    arr = self.dup
    acc = arr.shift unless acc
    arr.each { |el| acc = prc.call(acc, el) }
    acc
  end
end

# ~4min, ~2min



# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def prime?(num)
  (2...num).none? { |fact| num % fact == 0 }
end

def primes(num)
  return [] if num < 1
  primes = [2]
  i = 3
  while primes.length < num
    primes << i if prime?(i)
    i += 1
  end
  primes
end

# ~6min

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

# def factorials_rec(num)
#   return [1] if num == 1
#   prev_fact = factorials_rec(num-1)
#   new_fact = (num-1) * prev_fact.last
#   prev_fact << new_fact
# end

def factorials_rec(num)
  return [1].take(num) if num < 2
  prev_facts = factorials_rec(num - 1)
  prev_facts << (num - 1) * prev_facts[-1]
end



class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    hash = Hash.new { |h,k| h[k] = [] }
    self.each_with_index { |n, i| hash[n] << i }
    hash.select { |k,v| v.length > 1 }
  end
end

# ~2min

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    subs = []
    (0...self.length).each do |idx1|
      (idx1+1...self.length).each do |idx2|
        sub = self[idx1..idx2]
        subs << sub if sub == sub.reverse
      end
    end
    subs
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new { |x,y| x <=> y }
    return self if self.length < 2

    mid_idx = self.length / 2
    left = self.take(mid_idx)
    right = self.drop(mid_idx)

    sorted_left = left.merge_sort(&prc)
    sorted_right = right.merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)
  end

  private
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
end








































# require 'byebug'
# class Array

#   def my_inject(acc = nil, &prc)
#     start_idx = 0
#     if acc.nil?
#       acc = self[0]
#       start_idx += 1
#     end
#     (start_idx...self.length).each do |idx|
#       acc = prc.call(acc, self[idx])
#     end
#     acc
#   end
# end

# # ~4min



# # primes(num) returns an array of the first "num" primes.
# # You may wish to use an is_prime? helper method.

# def prime?(num)
#   (2...num).each { |fact| return false if num % fact == 0 }; true
# end

# def next_prime(last)
#   (last+1..last**2).each do |fact|
#     if prime?(fact)
#       return fact
#     end
#   end
# end

# def primes(num)
#   return [] if num < 1
#   primes = [2]
#   until primes.length >= num
#     primes << next_prime(primes.last)
#   end
#   primes
# end

# # ~6min

# # Write a recursive method that returns the first "num" factorial numbers.
# # Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# # is 1!, the 3rd factorial is 2!, etc.

# # def factorials_rec(num)
# #   return [1] if num == 1
# #   prev_fact = factorials_rec(num-1)
# #   new_fact = (num-1) * prev_fact.last
# #   prev_fact << new_fact
# # end

# def factorials_rec(num)
#   return [1] if num == 1

#   prev_facts = factorials_rec(num-1)
#   next_fact = prev_facts.last * (num-1)

#   prev_facts << next_fact
# end



# class Array

#   # Write an Array#dups method that will return a hash containing the indices of all
#   # duplicate elements. The keys are the duplicate elements; the values are
#   # arrays of their indices in ascending order, e.g.
#   # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

#   def dups
#     hash = Hash.new { |h,k| h[k] = [] }
#     self.each_with_index { |ele, idx| hash[ele] << idx}
#     hash.select { |k,v| v.length > 1 } 
#   end
# end

# class String

#   # Write a String#symmetric_substrings method that returns an array of substrings
#   # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
#   # Only include substrings of length > 1.

#   def symmetric_substrings
#     subs = []
#     (0...self.length).each do |idx1|
#       (idx1 + 1...self.length).each do |idx2|
#         subs << self[idx1..idx2] if self[idx1..idx2] == self[idx1..idx2].reverse
#       end
#     end
#     subs
#   end
# end

# class Array

#   # Write an Array#merge_sort method; it should not modify the original array.

#   def merge_sort(&prc)
#     prc ||= Proc.new { |x,y| x <=> y }

#     return self if self.length <= 1

#     mid = self.length / 2
#     left = self[0...mid].merge_sort(&prc)
#     right = self[mid...self.length].merge_sort(&prc)

#     Array.merge(left, right, &prc)
#   end

#   private
#   def self.merge(left, right, &prc)
#     merged = []
#     until left.empty? || right.empty?
#       if prc.call(left.first, right.first) == 1
#         merged << left.shift
#       else
#         merged << right.shift
#       end
#     end
#     merged + left + right
#   end
# end

## ___________________________________________

class Array

  def merge_sort(&prc)
    prc ||= Proc.new { |num_1, num_2| num_1 <=> num_2 }
    return self if self.count < 2
    middle = self.count / 2
    left, right = self.take(middle), self.drop(middle)
    sorted_left, sorted_right = left.merge_sort(&prc), right.merge_sort(&prc)
    Array.merge(sorted_left, sorted_right, &prc)

  end

  def merge_sort(&prc)
    prc ||= Proc.new { |num_1, num_2| num_1 <=> num_2 }
    return self if self.length == 1

    mid_idx = self.length / 2
    left, right = self.take(mid_idx)

  end





  private
  def self.merge(left, right, &proc)
    sorted = []
    until left.empty? || right.empty?
      if proc.call(left.first, right.first) == -1
        sorted << left.shift
      else
        sorted << right.shift
      end
    end
    sorted + left + right 
  end
end

# p [5,4,3,2].merge_sort { |num_1, num_2| num_2 <=> num_1 }