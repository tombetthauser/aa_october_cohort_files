class Array

  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end
  
  # return_value = [1, 2, 3].my_each do |num|
  #   puts num
  # end.my_each do |num|
  #   puts num
  # end
  # # => 1
  #     #  2
  #     #  3
  #     #  1
  #     #  2
  #     #  3
  
  # p return_value  # => [1, 2, 3]

  def my_select(&prc)
    selected = []
    self.my_each do |ele|
      if prc.call(ele)
        selected << ele
      end
    end
    selected
  end
  
  # p a = [1, 2, 3]
  # p a.my_select { |num| num > 1 } # => [2, 3]
  # p a.my_select { |num| num == 4 } # => []
  
  def my_reject(&prc)
    rejected = []
    self.my_each do |ele|
      unless prc.call(ele)
        rejected << ele
      end
    end
    rejected
  end

  # p a = [1, 2, 3]
  # p a.my_reject { |num| num > 1 } # => [1]
  # p a.my_reject { |num| num == 4 } # => [1, 2, 3]

  def my_any?(&prc)
    self.my_each do |ele|
      if prc.call(ele)
        return true
      end
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |ele|
      unless prc.call(ele)
        return false
      end
    end
    true
  end

  # p a = [1, 2, 3]
  # p a.my_any? { |num| num > 1 } # => true
  # p a.my_any? { |num| num == 4 } # => false
  # p a.my_all? { |num| num > 1 } # => false
  # p a.my_all? { |num| num < 4 } # => true

  def my_flatten
    one_dimensional = []

    self.my_each do |ele|
      if !ele.is_a?(Array)
        one_dimensional << ele
      else
        one_dimensional += ele.my_flatten
      end
    end

    one_dimensional
  end

  # p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

  def my_zip(*arrs)
    return_arr = []
    (0...self.length).each do |idx|
      sub_arr = [self[idx]]
      arrs.each { |sub| sub_arr << sub[idx] }
      return_arr << sub_arr
    end
    return_arr
  end

  # a = [ 4, 5, 6 ]
  # b = [ 7, 8, 9 ]
  # p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  # p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
  # p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

  # c = [10, 11, 12]
  # d = [13, 14, 15]
  # p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

  def my_rotate(num = 1)
    rotated = []

    self.each_with_index do |ele, i|
      rotated << self[(i + num) % self.length]
    end

    rotated
  end

  # a = [ "a", "b", "c", "d" ]
  # p a.my_rotate         #=> ["b", "c", "d", "a"]
  # p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
  # p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
  # p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

  def my_join(spacer = "")
    return_str = ""
    (0...self.length - 1).each do |idx| 
      return_str += (self[idx] + spacer)
    end
    return_str + self[-1]
  end

  # a = [ "a", "b", "c", "d" ]
  # p a.my_join         # => "abcd"
  # p a.my_join("$")    # => "a$b$c$d"

  def my_reverse
    reversed = []
    self.each do |ele|
      reversed.unshift(ele) 
    end
    reversed
  end

  # p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
  # p [ 1 ].my_reverse               #=> [1] 

  def bubble_sort!(&prc)
    prc ||= Proc.new { |x,y| x <=> y }
    sorted = false
    while !sorted
      sorted = true
      (0...self.length - 1).each do |idx|
        if prc.call(self[idx], self[idx + 1]) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end



  # prc = Proc.new { |x,y| y <=> x }
  # p arr = (0..10).to_a.shuffle
  # p arr = [1,4,6,2,8,3,5]
  # p arr.bubble_sort!(&prc)
  # p arr.bubble_sort! { |x,y| y <=> x }
  # p arr.bubble_sort!
  
  # prc = Proc.new { |x,y| y <=> x }
  # p arr = (0..10).to_a.shuffle
  # p arr = [1,4,6,2,8,3,5]
  # p arr.bubble_sort(&prc)
  # p arr.bubble_sort { |x,y| y <=> x }
  # p arr.bubble_sort
  
end

def factors(num)
    (1..num).select { |fact| num % fact == 0 }
end

def substrings(string)
  subs = []
  (0...string.length).each do | startIndx |
    (startIndx...string.length).each do | endIndx |
      subs << string[startIndx..endIndx]
    end
  end
  subs
end

def subwords(word, dict)
  subs = []
  (0...word.length).each do |idx1|
    (idx1...word.length).each do |idx2|
      subs << word[idx1..idx2]
    end
  end
  subs.select { |sub| dict.include?(sub) }
end


p subwords("applet", ["app", "apple", "let", "lets", "pa"])

# p substrings("cat")

# p factors(2)
# p factors(20)
# p factors(7)


