require_relative "board.rb"
require_relative "human_player.rb"

class Game

    attr_reader :player_1, :player_2, :board
    attr_accessor :current_player

    def initialize
        puts "Player 1: "
        @player_1 = HumanPlayer.new
        puts "Player 2: "
        @player_2 = HumanPlayer.new
        @board = Board.new
        @current_player = self.player_1
    end

    def switch_turn
        if self.current_player == self.player_1
            self.current_player = self.player_2
        else
            self.current_player = self.player_1
        end
    end

    def play
        while self.board.empty_positions?
            self.board.print
            move = self.current_player.get_position
            mark = current_player.mark
            self.board.place_mark(move, mark)
            if self.board.win?(mark)
                puts "Player #{current_player.mark} has won the game!!"
                return self.board.print
            end
            self.switch_turn
        end
        puts "Draw"
        return self.board.print
    end

end