# def first_anagram?(str1, str2)
#     possible_anagrams(str1).include?(str2)
# end

# def possible_anagrams(string)
#     anagrams = []
#     final_length = (1..string.length).inject(:*)
#     # count = 0

#     until anagrams.length >= final_length
#     #   count += 1
#       new_anagram = string.split("").shuffle.join("")
#       anagrams << new_anagram unless anagrams.include?(new_anagram)
#     end
#     # p count
#     anagrams
    


# #  return [string] if string.length <=1 
# #   current_anagram = possible_anagrams(string[0...-1])
# #   anagrams = []
# #   current_anagram.each do |ele|
   
# #     (0..ele.length).each do |idx1|
        
# #       anagrams << string[idx1]
# #     end
# #   end
# #   p anagrams

# end

# p first_anagram?( "cameralistic", "acclimatiser")
# p first_anagram?("gizmo", "sally")    #=> false
# p possible_anagrams("cat")


# Exponential? or O(n!)




def anagram?(str1, str2)
  until str2.length < 1
    return false if str1.length < 1
    
    if str2.include?(str1[0])
      temp_idx = str2.split("").index(str1[0])
      str2 = str2[0...temp_idx] + str2[temp_idx + 1..-1]
    end 
    
    str1 = str1[1..-1]
    
  end
  true
end


# def anagram?(str1, str2)
#   str1 = str1.split("")
#   str2 = str2.split("")
  
#   str1.each do |letter|
#     temp_idx = str2.find_index(letter)
#     return true if !temp_idx.nil?
#     str2.delete(temp_idx)
#   end
# str2.empty?

# end


# p anagram?("gizmo", "sally")    #=> false
# p anagram?( "cameralistic", "acclimatiser")
# p anagram?("gizmo", "sally")    #=> false
# 


# Linear or maybe quadratic?






def anagrams?(str1, str2)
  sorted = [str1, str2]

  sorted.map! { |string| string.split("").sort.join("") }

  sorted[0] == sorted[-1]

end

# p anagrams?("gizmo", "sally")    #=> false
# p anagrams?( "cameralistic", "acclimatiser")


def anagrams?(str1, str2)
    hash1 = Hash.new(0)
    hash2 = Hash.new(0)

    str1.each_char{ |char| hash1[char] += 1 }
    str2.each_char{ |char| hash2[char] += 1 }

    hash1 == hash2

end

p anagrams?("gizmo", "sally")    #=> false
p anagrams?( "cameralistic", "acclimatiser")






