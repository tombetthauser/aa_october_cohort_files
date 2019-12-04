class HumanPlayer

    def self.get_mark
        puts "Please enter a capital letter to represent your player"
        gets.chomp.to_sym
    end

    attr_reader :mark

    def initialize
        @mark = HumanPlayer.get_mark
    end

    def get_position
        puts "Player #{self.mark}, enter a position in the form 'row col'"
        position = gets.chomp.split(" ")
        position.each do |ele|
            nums = (0..100).map(&:to_s)
            raise "Too many numbers" if position.length > 2
            raise "Too few numbers" if position.length < 2
            unless nums.include?(ele)
                raise "Please enter a number next time"
            end
        end
        position.map(&:to_i)
    end

end