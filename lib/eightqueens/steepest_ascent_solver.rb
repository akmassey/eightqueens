module EightQueens
  class SteepestAscentSolver
    attr_reader :state, :steps, :solved

    def initialize(start_state)
      @state = start_state
      @steps = 0
      @solved = false
    end

    def solve
      until @solved
        if @state.best_move! == false
          @solved = true
        else
          @steps += 1
        end
      end

      @steps
    end

    def solution
      solve unless @solved

      @state
    end
  end
end
