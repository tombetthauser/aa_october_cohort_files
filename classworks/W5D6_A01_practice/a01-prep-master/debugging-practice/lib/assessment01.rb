class Array

  def my_inject(acc = nil, &prc)
    if acc.nil?
      acc = self.first
      (1...self.length).each do |idx|
        acc = prc.call(acc, self[idx])
      end
      acc
    else
      (0...self.length).each do |idx|
        acc = prc.call(acc, self[idx])
      end
      acc
    end
  end

end

# ~5min




def prime?(num)
  return false if num < 2
  (2...num).none? { |fact| num % fact == 0 }
end


def primes(input_count)
  primes = []
  i = 2
  until primes.length >= input_count
    primes << i if prime?(i)
    i += 1
  end
  primes
end

# ~7min (got stuck on / instead of %)











# # The "calls itself recursively" spec may say that there is no method
# # named "and_call_original" if you are using an older version of
# # rspec. You may ignore this failure.
# # Also, be aware that the first factorial number is 0!, which is defined
# # to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.



def factorials_rec(num)
  return [1,1,2].take(num) if num < 3
  facts = factorials_rec(num-1)
  facts + [ facts.last * (num-1) ]
end

# ~4min













class Array

  def dups
    hash = Hash.new { |h,k| h[k] = [] }
    (0...self.length).each do |idx|
      hash[self[idx]] << idx
    end
    hash.select { |k,v| v.length > 1 }
  end

end

# ~2min










class String

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

# ~3min (kind of cheated with .include? on 120?)









class Array
  def merge_sort(&prc)
    # See how I create a Proc if no block was given; this eliminates
    # having to later have two branches of logic, one for a block and
    # one for no block.

    prc ||= Proc.new { |a,b| a <=> b }

    return self if self.length < 2

    mid = self.length / 2
    left = self[0...mid]
    right = self[mid..-1]

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

# ~3min

# 45 min total with break / texting




# ~24min rusty