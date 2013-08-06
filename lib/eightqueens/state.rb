require 'pry'

module EightQueens
  class State
    def initialize(queen_positions)
      raise "Invalid queen positions" unless valid_queen_positions(queen_positions)
      @queens = queen_positions
    end

    # returns the number of queens horizontally attacking one another
    def horizontal_attacks
      attacks = 0

      pairs.each do |pair|
        attacks += 1 if (pair[0] == pair[1])
      end

      attacks
    end

    def valid_queen_positions(positions)
      if positions.match(/[1-8]{8}/)
        true
      else
        false
      end
    end

    def pairs
      queen_array = @queens.split(//)

      pairs = []
      queen_array.product(queen_array) do |first, second|
        pairs << [first, second]
      end

      diagonals = queen_array.zip(queen_array)

      diagonals.each do |d|
        pairs.delete_at(pairs.index(d)) unless pairs.index(d).nil?
      end

      pairs
    end
  end
end
