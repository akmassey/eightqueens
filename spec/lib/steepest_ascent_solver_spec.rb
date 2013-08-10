require 'spec_helper'

module EightQueens
  describe SteepestAscentSolver do

    context "#solve" do 
      it "should solve an incorrect puzzle" do
        incorrect = State.new("23456781")
        solver = SteepestAscentSolver.new( incorrect )

        solver.solve

        solver.steps.should_not eq 0
        solver.state.best_move!.should be false
      end

      it "should not take any steps for a solution state" do
        solution = State.new("24683175")
        solver = SteepestAscentSolver.new( solution )

        solver.solve

        solver.steps.should eq 0
        solver.state.best_move!.should be false
      end
    end
  end
end
