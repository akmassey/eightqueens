module EightQueens
  class State
    def initialize(queen_positions)
      raise "Invalid queen positions" unless valid_queen_positions(queen_positions)
      @queens = queen_positions
    end

    # returns the number of queens horizontally attacking one another
    def horizontal_attacks
      attacks = 0

      for char in '1'..'8'
        count = @queens.count(char)
        if count > 1
          attacks += count - 1
        end
      end

      attacks
    end

    private

    def valid_queen_positions(positions)
      if positions.match(/[1-8]{8}/)
        true
      else
        false
      end
    end
  end
end
