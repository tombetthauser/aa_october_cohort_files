def first_anagram?(str1, str2)
    possible_anagrams(str1).include?(str2)
end

def possible_anagrams(string)
    anagrams = []
    final_length = (1..string.length).inject(:*)

    until anagrams.length >= final_length
      new_anagram = string.split("").shuffle.join("")
      anagrams << new_anagram unless anagrams.include?(new_anagram)
    end

    anagrams


#  return [string] if string.length <=1 
#   current_anagram = possible_anagrams(string[0...-1])
#   anagrams = []
#   current_anagram.each do |ele|
   
#     (0..ele.length).each do |idx1|
        
#       anagrams << string[idx1]
#     end
#   end
#   p anagrams

end

p first_anagram?("elvis", "lives")
p first_anagram?("gizmo", "sally")    #=> false
p possible_anagrams("cat")





#  anagrams = []
#     (0...string.length).each do |idx1|
#         (0...string.length).each do |idx2|
#             anagrams << string[idx1..idx2]
#         end
#     end
  
#     anagrams.uniq



