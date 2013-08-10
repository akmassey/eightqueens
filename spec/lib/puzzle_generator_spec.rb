require 'spec_helper'

module EightQueens
  describe PuzzleGenerator do
    it "should create the number of puzzles requested on initialization" do
      pg = PuzzleGenerator.new(100)
      pg.puzzles.size.should eq 100
    end

    it "should be able to add additional puzzles after initialized" do
      pg = PuzzleGenerator.new(50)
      pg.create_more_puzzles(50)
      pg.puzzles.size.should eq 100
    end
  end
end
