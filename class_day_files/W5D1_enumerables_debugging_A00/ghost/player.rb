# require_relative "game"

class Player
    def initialize(name)
        @name = name.capitalize
    end

    def guess
        p "#{@name} please enter a letter: "
        input = gets.chomp
    end

    def alert_invalid_guess
        p "#{@name} your guess is invalid"
    end
end