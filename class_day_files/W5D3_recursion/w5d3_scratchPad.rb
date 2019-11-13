class Array

  def qsort
    return self if self.length < 2

    pivot = self.first
    left = self[1..-1].select { |n| n <= pivot }
    right = self[1..-1].select { |n| n > pivot }

    left.qsort + [pivot] + right.qsort
  end

end

# solved in under 5min!


p a = (1..25).to_a.shuffle
p a.qsort