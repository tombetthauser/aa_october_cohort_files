require "byebug"

class Array

  def qsort
    return self if size < 2
    pivot = self.last
    left = self[0...-1].select { |n| n < pivot }
    right = self[0...-1].select { |n| n >= pivot }
    left.qsort + [pivot] + right.qsort
  end

end

# solved in under 5min!


p a = (1..10).to_a.shuffle
p a.qsort