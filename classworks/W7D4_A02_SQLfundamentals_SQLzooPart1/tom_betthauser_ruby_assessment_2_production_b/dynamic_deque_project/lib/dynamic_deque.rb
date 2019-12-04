require_relative "deque"

class DynamicDeque < Deque

  attr_reader :max_volume

  def initialize(num)
    super()
    @max_volume = num
  end

  def middle
    return @concealed_array if self.blank?
    mid = self.size/2
    if self.size.even?
      [@concealed_array[mid - 1], @concealed_array[mid]]
    else
      [@concealed_array[mid]]
    end
  end

  def push_back(*args)
    raise "deque is full" if (self.size + args.size) > self.max_volume
    args.each { |arg| super(arg) }
    self.size
  end

  def pop_front(n = nil)
    return [super()] if n == nil
    removed = []
    n.times { removed << super() }
    removed
  end

end