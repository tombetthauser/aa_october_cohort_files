class Array
  # Write a new `Array#merge_sort` method; it should not modify the
  # array it is called on, but create a new sorted array.
  def merge_sort(&prc)
    prc ||= Proc.new { |a,s| a <=> s }
    return self if self.length < 2

    mid = self.length / 2
    left = self[0...mid]
    right = self[mid..-1]

    left_sorted = left.merge_sort(&prc)
    right_sorted = right.merge_sort(&prc)

    Array.merge(left_sorted, right_sorted, &prc)
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

class Array
  # Write an array method that returns `true` if two elements of the array sum
  # to 0 and `false` otherwise
  def two_sum
    pairs = []

    (0...self.length).each do |idx1|
      (0...self.length).each do |idx2|
        pair = [self[idx1], self[idx2]]
        pairs << pair if pair.sum == 0 && idx1 != idx2
      end
    end

    pairs.length > 0
  end
end

# Write a method that finds the first `n` Fibonacci numbers recursively.
def fibs_rec(count)
  return [0,1,1].take(count) if count < 3
  prev_fibs = fibs_rec(count - 1)
  prev_fibs + [prev_fibs[-2] + prev_fibs[-1]]
end

class String
  # Write a method that returns `true` if all characters in the string
  # are unique and `false` if they are not
  def all_unique_chars?
    uniqs = ""
    all = ""

    self.each_char do |char|
        uniqs += char unless uniqs.include?(char) || char == " "
        all += char unless char == " "
    end

    all == uniqs
  end
end

# Write a method that returns the largest prime factor of a number
def largest_prime_factor(num)
  return nil if num < 2
  (1..num).inject do |acc, fact|
    if num % fact == 0 && prime?(fact) && fact >= acc
      fact
    else
      acc
    end
  end
end

# You are not required to implement this; it's here as a suggestion :-)
def prime?(num)
  return false if num < 2
  (2...num).none? { |fact| num % fact == 0 }
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end
end

class Array
  # Write an array method that returns `true` if all elements in an array
  # return `true` for the passed block and `false` otherwise 
  def my_all?(&prc)
    all = true

    i = 0
    while i < self.length
      all = false if all == false || !prc.call(self[i])
      i += 1
    end

    all
  end
end

