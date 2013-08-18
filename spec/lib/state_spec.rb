require 'spec_helper'

module EightQueens
  describe State do

    let(:solution) { State.new("24683175") }
    let(:bad) { State.new("22222222") }
    let(:also_bad) { State.new("23456781") }

    context "#initialize" do

      it "should be instantiable" do
        s = State.new("12345678")
        s.should_not be nil
      end

      it "should raise an error when instantiated with invalid queen positions" do
        expect {State.new("alpha")}.to raise_error
        expect {State.new("abcdefgh")}.to raise_error
        expect {State.new("1234567h")}.to raise_error
      end

    end

    context "#horizontal_attacks" do

      it "should return 0 for a solution to the eight queens puzzle" do
        solution.horizontal_attacks.should eq 0
      end

      it "should return something else for a non-solution" do
        bad.horizontal_attacks.should be > 0
      end

      it "should return 1 for a solution with only one horizontally attacking pair" do
        state = State.new("22345678")
        state.horizontal_attacks.should eq 1
      end
    end

    context "#diagonal_attacks" do

      it "should return 0 for a solution to the eight queens puzzle" do
        solution.diagonal_attacks.should eq 0
      end

      it "should return 0 for a non-solution with no diagonal attacks" do
        bad.diagonal_attacks.should eq 0
      end

      it "should return something else for a non-solution" do
        also_bad.diagonal_attacks.should be > 0
      end
    end

    context "#attacks" do

      it "should return 0 for a solution to the eight queens puzzle" do
        solution.attacks.should eq 0
      end

      it "should return something else for a non-solution" do
        bad.attacks.should be > 0
        also_bad.attacks.should be > 0
      end

      it "should find 4 attacking pairs for 24748552" do
        state = State.new("24748552")
        state.attacks.should eq 4
      end

      it "should find 5 attacking pairs for 32752411" do
        state = State.new("32752411")
        state.attacks.should eq 5
      end

      it "should find 8 attacking pairs for 24415124" do
        state = State.new("24415124")
        state.attacks.should eq 8
      end

      it "should find 17 attacking pairs for 32543213" do
        state = State.new("32543213")
        state.attacks.should eq 17
      end
    end

    context "#friendly_pairs" do
      it "should return 28 for a solution to eight queens puzzle" do
        solution.friendly_pairs.should eq 28
      end

      it "should return less than 28 for a non-solution" do
        bad.friendly_pairs.should be < 28
        also_bad.friendly_pairs.should be < 28
      end
    end

    context "#randomize" do
      # TODO: there is a chance this could fail
      it "should change the position of the queens" do
        before = solution.queens
        10.times do
          solution.randomize
        end
        solution.queens.should_not eq before
        solution.attacks.should be > 0
      end
    end

    context "#move_to" do
      it "should update the queen positions" do
        solution.move_to("22222222")
        solution.queens.should eq "22222222"
        solution.attacks.should be > 0
      end

      it "should raise an error when provided with invalid queen positions" do 
        expect{solution.move_to("alpha")}.to raise_error
      end
    end

  end
end
