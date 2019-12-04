require_relative "board.rb"

class ComputerPlayer

    attr_reader :mark

    def initialize
        @mark = (1..9).to_a.sample
    end

    def get_position
        Board.valid_positions.sample
    end

end