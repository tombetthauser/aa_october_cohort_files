require 'byebug'
class Array

  def my_inject(accumulator = nil, &prc)
    if accumulator.nil?
      accumulator = self.first
      (1...self.length).each do |idx|
        accumulator = prc.call(accumulator, self[idx])
      end
    else
      (0...self.length).each do |idx|
        accumulator = prc.call(accumulator, self[idx])
      end
    end
    accumulator
  end

end



# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2...num).each { |fact| return false if num % fact == 0 }; true
end

def primes(num)
  return [] if num < 1
  primes = [2]
  i = 3
  until primes.length >= num
    if is_prime?(i)
      primes << i
    end
    i += 1
  end
  primes
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  return [1,1] if num == 2
  factorials_rec(num-1) + [factorial(num)]
end

def factorial(num)
  (1...num).inject { |acc, n| acc *= n }
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    hash = Hash.new { |h,k| h[k] = [] }
    self.each_with_index { |ele, idx| hash[ele] << idx}
    hash.select { |k,v| v.length > 1 } 
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    subs = []
    (0...self.length).each do |idx1|
      (idx1 + 1...self.length).each do |idx2|
        subs << self[idx1..idx2] if self[idx1..idx2] == self[idx1..idx2].reverse
      end
    end
    subs
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new { |l,r| l.first <=> r.first }
    return self if length < 2

    mid = length / 2
    left = self[0...mid].merge_sort(&prc)
    right = self[mid..-1].merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    if left.empty?
      right
    elsif right.empty?
      left
    elsif prc.call(left, right) < 1
      [left.first] + merge(left[1..-1], right, &prc)
    else
      [right.first] + merge(left, right[1..-1], &prc)
    end
  end
end

## ___________________________________________

class Array

  def merge_sort(&prc)
    prc ||= Proc.new { |num_1, num_2| num_1 <=> num_2 }
    return self if self.count < 2
    middle = self.count / 2
    left, right = self.take(middle), self.drop(middle)
    sorted_left, sorted_right = left.merge_sort(&prc), right.merge_sort(&prc)
    # debugger
    Array.merge(sorted_left, sorted_right, &prc)

  end

  private
  def self.merge(left, right, &proc)
    #debugger
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

p [5,4,3,2].merge_sort { |num_1, num_2| num_2 <=> num_1 }