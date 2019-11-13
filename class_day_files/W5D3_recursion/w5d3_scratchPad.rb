require "byebug"

class Array

  def qsort
    return self if size < 2

    p = self.first
    l = self[1..-1].select { |n| n < p }
    r = self[1..-1].select { |n| n >= p }

    l.qsort + [p] + r.qsort
  end

end

# solved in under 5min!
# solved in a new way in around 7min
# solved in 1.3min!


p a = (1..10).to_a.shuffle
p a.qsort