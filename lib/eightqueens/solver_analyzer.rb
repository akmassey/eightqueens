module EightQueens
  class SolverAnalyzer
    def initialize(solver_class, puzzle_generator)
      @solver = solver_class
      @puzzle_generator = puzzle_generator
      @steps = []
      @puzzle = []

      solve_all_puzzles
    end

    def solve_all_puzzles
      @puzzle_generator.puzzles.each_with_index do |p, i|
        s = @solver.new(p)
        @steps[i] = s.solve
        @puzzle[i] = s.state
      end
    end

    def average_steps
      solve_all_puzzles if @steps.length == 0

      total = @steps.reduce(0) { |accumulator, value| accumulator += value }
      total / @steps.length.to_f
    end

    def average_attacks
      solve_all_puzzles if @puzzle.length == 0

      total = @puzzle.reduce(0) { |accumulator, value| accumulator += value.attacks }
      total / @puzzle.length.to_f
    end

    def to_s
      "Puzzles Solved: #{@puzzle.length}\nAverage Steps: #{average_steps}\nAverage Attacks: #{average_attacks}"
    end

  end
end
