module EightQueens
  class FirstChoiceSolver
    attr_reader :state, :steps, :solved

    def initialize(start_state)
      @state = start_state
      @steps = 0
      @solved = false
    end

    # TODO: should we move the best move to this class?
    def solve
      until @solved
        if @state.first_choice! == false
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
