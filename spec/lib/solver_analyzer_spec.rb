require 'spec_helper'

module EightQueens
  describe SolverAnalyzer do

    it "should report the average number of steps taken" do
      sa = SolverAnalyzer.new(SteepestAscentSolver, PuzzleGenerator.new(100))

      sa.average_steps.should be > 0
    end

    it "should report the average number of attacks remaining on the puzzles" do
      sa = SolverAnalyzer.new(SteepestAscentSolver, PuzzleGenerator.new(100))

      puts "Average attacks: #{sa.average_attacks}"
      sa.average_attacks.should be > 0
    end

  end
end
