require 'spec_helper'

module EightQueens
  describe RandomRestartSolver do
    let(:incorrect) { State.new("23456781") }
    let(:solution) { State.new("24683175") }

    context "#solve" do 
      it "should be able to solve an incorrect puzzle" do
        solver = RandomRestartSolver.new(incorrect)

        solver.solve

        solver.steps.should_not eq 0
        solver.solved.should be true
      end

      it "should not take any steps for a solution state" do
        solver = RandomRestartSolver.new(solution)

        solver.solve

        solver.steps.should eq 0
        solver.solved.should be true
      end
    end

  end
end

