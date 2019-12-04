require_relative "computer_player.rb"
require_relative "board.rb"
require_relative "human_player.rb"

class Game
    # puts "Player 2: "
    # puts "Player 1: "

    attr_reader :players, :board
    attr_accessor :current_player

    def initialize(board_size, player_count)
        # @player_1 = HumanPlayer.new
        # @player_2 = HumanPlayer.new

        @players = Array.new(player_count) { HumanPlayer.new }
        @players << ComputerPlayer.new
        @board = Board.new(board_size)
        @current_player = self.players[0]
    end

    def switch_turn
       old_idx = self.players.index(self.current_player)
       new_idx = (old_idx + 1) % self.players.length
       self.current_player = self.players[new_idx]
    end 

    def play
        while self.board.empty_positions?
            self.board.print
            puts "-----------"
            if self.players.index(self.current_player) < self.players.length - 1
                # debugger
                move = self.current_player.get_position 
            else
                move = self.board.valid_positions.sample
            end

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