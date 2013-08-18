module EightQueens
  class FirstChoiceSolver
    attr_reader :state, :steps, :solved

    def initialize(start_state)
      @state = start_state
      @steps = 0
      @solved = false
    end

    def solve
      successor, @steps = find_first_choice

      @state = successor if successor
      @solved = true
      @steps
    end

    def solution
      solve unless @solved

      @state
    end

    def find_first_choice
      steps = 0
      if (@solved || @state.attacks == 0)
        @solved = true
        return [nil, steps] 
      end

      @state.generate_successors do |successor|
        steps += 1
        return [successor, steps] if successor.attacks < @state.attacks
      end

      [nil, steps]
    end

  end
end
