def my_min(list)
  min = nil
  list.each do |n1|
    # list2 = list[0...idx1] + list[idx1+1..-1]
    list2 = list.dup
    list2.delete(n1)
      min = n1 if list2.all? { |n| n1 < n }
  end
  min
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
 p  my_min(list)  # =>  -5
