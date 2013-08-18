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
        unless find_best_move
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

    def find_best_move
      return false if @state.attacks == 0

      best_state = identify_best_state

      if best_state.attacks < @state.attacks
        @state.move_to(best_state.queens)
        return true
      end

      false
    end

    # identifies the best state from the state's successors
    def identify_best_state
      best = EightQueens::NullState.new
      found_best_state = false

      @state.generate_successors do |successor|
        best = successor if best.friendly_pairs < successor.friendly_pairs
        found_best_state = true
      end

      found_best_state ? best : @state
    end

  end
end
