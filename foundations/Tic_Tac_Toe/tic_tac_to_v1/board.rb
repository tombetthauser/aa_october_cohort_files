require "byebug"
class Board

    attr_reader :grid

    def initialize
        @grid = Array.new(3) { Array.new(3, '_') }
    end

    def [](position)
        row, col = position
        self.grid[row][col]
    end

    def []=(position, mark)
        row, col = position
        self.grid[row][col] = mark
    end

    def valid?(position)
        row, col = position
        return false if row < 0 || col < 0
        return false if row > self.grid.length || col > self.grid.length
        true
    end

    def empty?(position)
        return false if self[position] != '_'
        true
    end

    def place_mark(position, mark)
        if self.valid?(position) && self.empty?(position)
            self[position] = mark
        else
            raise "Invalid position"
        end
    end

    def print
        self.grid.each do |row|
            puts row.join(" ")
        end
    end

    def win_row?(mark)
        self.grid.each do |row|
            if row.all? { |ele| ele == mark && ele != '_' }
                return true
            end
        end
        false
    end

    def win_col?(mark)
        self.grid.transpose.each do |row|
            if row.all? { |ele| ele == mark && ele != '_' }
                return true
            end
        end
        false
    end

    def diagonal_win?(mark)
        self.diagonal_same?(mark) || self.other_diagonal_same?(mark)
    end

    def diagonal_same?(mark)
        (0...self.grid.length).each do |i|
            position = [i, i]
            return false if self[position] != mark
        end
        true
    end

    def other_diagonal_same?(mark)
        row = 0
        col = self.grid.length - 1
        while row < self.grid.length 
            position = [row, col]
            return false if self[position] != mark
            row += 1
            col -= 1
        end
        true
    end

    def win?(mark)
        if self.win_row?(mark) || self.win_col?(mark) || self.diagonal_win?(mark)
            return true
        else
            return false
        end
    end

    def empty_positions?
        self.grid.each do |row|
           return true if row.any? { |ele| ele == '_' }
        end
        false
    end

end
