require "byebug"
require_relative 'tic_tac_toe'
class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      winner = @board.winner
      return @board.won? && winner != evaluator
    end

    if evaluator != @next_mover_mark
      children.any? { |child| child.losing_node?(evaluator) }
    else
      children.all? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      winner = @board.winner
      return @board.won? && winner == evaluator
    end

    if evaluator == @next_mover_mark
      children.any? { |child| child.winning_node?(evaluator) }
    else 
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  def children 
    children_nodes = []

    (0..2).each do |row_idx|
      (0..2).each do |col_idx|
        position = [row_idx, col_idx]
        if @board.empty?(position)
          board_dup = @board.dup
          board_dup[position] = @next_mover_mark
          next_mover_mark2 = @next_mover_mark == :x ? :o : :x

          children_nodes << TicTacToeNode.new(board_dup, next_mover_mark2, position)
        end
      end
    end

    children_nodes
  end
end
