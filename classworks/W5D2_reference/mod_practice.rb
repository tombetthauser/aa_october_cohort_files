system "clear"
loop do
  a = (-10..10).to_a.sample
  b = (-10..1).to_a.sample
  print "\n\n\n#{a} % #{b} = "

  b == 0 ? correct = "error" : correct = a % b

  input = gets.chomp.downcase
  input = input.to_i unless input.downcase == "error" 

  print "\nCorrect answer was #{correct}, "
  if input == correct 
    print "good job!"
  else
    print "try again!"
  end

  print "\n\n"
  25.times { print "_" }
end


