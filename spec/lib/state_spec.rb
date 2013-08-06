require 'spec_helper'

module EightQueens
  describe State do

    let(:solution) { State.new("24613578") }

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
        bad = State.new("22222222")
        bad.horizontal_attacks.should > 0
      end
    end

  end
end
