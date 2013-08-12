require 'logger'
require 'pry'

module EightQueens
  class State
    attr_accessor :queens

    def initialize(queen_positions)
      State.verify_queen_positions(queen_positions)
      @queens = queen_positions
      @queen_array = queen_positions.split(//)

      @log = Logger.new(STDOUT)
      @log.level = Logger::WARN
    end

    # returns the number of queens horizontally attacking one another
    def horizontal_attacks
      attacks = 0

      pairs.each do |pair|
        attacks += 1 if (pair[0] == pair[1])
      end

      attacks
    end

    # returns the number of queens diagonally attacking one another
    def diagonal_attacks
      attacks = 0

      queen_integers = @queen_array.map { |i| Integer(i) }

      queen_integers.each_with_index do |queen, column|
        for index in column..(queen_integers.length - 1)
          if (index != column) and ((queen == queen_integers[index] + (index-column)) or (queen == queen_integers[index] - (index-column)))
            @log.debug "ADDING ATTACK on queen: #{queen} in #{column}\tpartner: #{queen_integers[index]} in #{index}"
            attacks += 1
          end
        end
      end

      attacks
    end

    def attacks
      horizontal_attacks + diagonal_attacks
    end

    def friendly_pairs
      28 - attacks
    end

    def move_to(queen_positions)
      State.verify_queen_positions(queen_positions)

      @queens = queen_positions
      @queen_array = queen_positions.split(//)

      self
    end

    def randomize
      new_positions = @queen_array.shuffle.join
      move_to new_positions
    end

    # updates the state to the best state you can get to by moving a single
    # queen
    #
    # returns false if no move was made and true if a move was made
    def best_move!
      return false if attacks == 0

      best_state = State.identify_best_state( State.generate_successors( @queens ) )

      if best_state.attacks < self.attacks
        @queens = best_state.queens
        @queen_array = @queens.split(//)
        return true
      end

      false
    end

    def first_choice!
      return false if attacks == 0

      ints = @queen_array.map { |i| Integer(i) }

      ints.each_with_index do |queen, column|
        for index in 1..8
          unless index == queen
            temp = ints
            temp[column] = index
            s = State.new( temp.join("") )
            if s.attacks < self.attacks
              @queens = s.queens
              @queen_array = @queens.split(//)
              return true
            end
          end
        end
      end

      return false
    end

    # returns an array of States that are possible to create with one move
    # from the provided queen_positions
    # TODO: turn this into a successor-yielding method that expects a block
    def self.generate_successors(queen_positions)
      State.verify_queen_positions(queen_positions)

      possible_states = []

      ints = queen_positions.split(//).map { |i| Integer(i) }

      ints.each_with_index do |queen, column|
        for index in 1..8
          unless index == queen
            temp = ints
            temp[column] = index
            possible_states << State.new( temp.join("") )
          end
        end
      end

      possible_states
    end

    # identifies the best state from an array of states
    def self.identify_best_state(states)
      raise "Invalid set of states" if states.nil?

      best = states.first

      states.each do |s|
        best = s if best.attacks > s.attacks
      end

      best
    end

    def self.verify_queen_positions(positions)
      raise "Invalid queen positions: #{positions}" unless positions.match(/[1-8]{8}/)
    end

    def pairs
      @queen_array = @queens.split(//)

      pairs = []

      for i in 0..(@queen_array.length-1)
        for j in (i+1)..(@queen_array.length-1)
          pairs << [ @queen_array[i], @queen_array[j] ]
        end
      end

      # @queen_array.product(@queen_array) do |first, second|
      #   pairs << [first, second]
      # end

      # diagonals = @queen_array.zip(@queen_array)

      # diagonals.each do |d|
      #   pairs.delete_at(pairs.index(d)) unless pairs.index(d).nil?
      # end

      pairs
    end
  end
end
