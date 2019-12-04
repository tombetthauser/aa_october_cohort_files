class Deque

  def initialize
    @concealed_array = []
  end

  def size
    @concealed_array.count
  end

  def blank?
    @concealed_array.empty?
  end

  def front
    @concealed_array.first
  end

  def back
    @concealed_array.last
  end

  def push_back(item)
    @concealed_array << item
    self.size
  end

  def push_front(item)
    @concealed_array.unshift(item)
    self.size
  end

  def pop_back
    return nil if self.blank?
    @concealed_array.pop
  end
  
  def pop_front
    return nil if self.blank?
    @concealed_array.shift
  end

end