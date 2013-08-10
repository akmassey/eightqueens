module EightQueens
  class PuzzleGenerator
    attr_reader :puzzles

    def initialize(number_to_generate)
      @puzzles = []
      create_more_puzzles(number_to_generate)
    end

    def create_more_puzzles(number)
      number.times do |p|
        @puzzles.push(create_puzzle)
      end
    end

    def create_puzzle
      state = ""
      8.times do
        state += rand(1..8).to_s
      end

      State.new(state)
    end
  end
end
