require "byebug"
require_relative 'tic_tac_toe'
class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    # not understanding what inst variables
    # are these acting like parent / value / children?
    # are we storing our poly-tree in a single root node?
  end

  def losing_node?(evaluator)
    
  end

  def winning_node?(evaluator)
  end

  def children 
    children_nodes = []

    (0..2).each do |row_idx|
      (0..2).each do |col_idx|
        if @board.rows[row_idx][col_idx] == nil
          board_dup = @board.rows.map { |row| row.dup }
          board_dup[row_idx][col_idx] = @next_mover_mark
          next_mover_mark2 = @next_mover_mark == :x ? :o : :x
          prev_move_pos2 = [row_idx, col_idx]

          children_nodes << TicTacToeNode.new(board_dup, next_mover_mark2, prev_move_pos2)
        end
      end
    end

    children_nodes
  end
end
