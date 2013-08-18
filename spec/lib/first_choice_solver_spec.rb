require 'spec_helper'

module EightQueens
  describe FirstChoiceSolver do
    let(:incorrect) { State.new("23456781") }
    let(:solution) { State.new("24683175") }

    context "#find_first_choice" do
      it "should return [nil, 0] when called on a solved puzzle" do
        solver = FirstChoiceSolver.new(solution)
        solver.find_first_choice.should eq [nil, 0]
      end

      it "should return non-zero steps when called on an incorrect puzzle" do
        solver = FirstChoiceSolver.new(incorrect)
        solver.find_first_choice[1].should be > 0
      end
    end

    context "#solve" do 
      it "should be able to solve an incorrect puzzle" do
        solver = FirstChoiceSolver.new(incorrect)

        solver.solve

        solver.steps.should_not eq 0
        solver.solved.should be true
      end

      it "should not take any steps for a solution state" do
        solver = FirstChoiceSolver.new(solution)

        solver.solve

        solver.steps.should eq 0
        solver.solved.should be true
      end
    end

  end
end
