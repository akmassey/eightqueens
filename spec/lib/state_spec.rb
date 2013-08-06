require 'spec_helper'

module EightQueens
  describe State do
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
end
