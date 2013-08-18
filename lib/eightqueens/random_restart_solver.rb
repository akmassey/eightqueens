module EightQueens
  class RandomRestartSolver < SteepestAscentSolver
    attr_reader :state, :steps, :solved

    def initialize(start_state)
      super
      @candidates = []
    end

    def solve
      if @state.attacks == 0
        @solved = true
        return 0
      end

      10.times do
        @candidates << next_candidate
        @state.randomize
      end

      @candidates.sort { |x,y| x[0].attacks <=> y[0].attacks }

      @state = @candidates.first[0]
      @steps = @candidates.first[1]
      @solved = true

      @steps
    end

    def next_candidate
      best_move = false
      steps = 0
      until best_move
        unless find_best_move
          best_move = true
        else
          steps += 1
        end
      end

      return @state, steps
    end

  end
end

