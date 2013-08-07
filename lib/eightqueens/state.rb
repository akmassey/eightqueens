require 'logger'
require 'pry'

module EightQueens
  class State
    def initialize(queen_positions)
      raise "Invalid queen positions" unless valid_queen_positions(queen_positions)
      @queens = queen_positions

      @log = Logger.new(STDOUT)
      @log.level = Logger::WARN
    end

    # returns the number of queens horizontally attacking one another
    # TODO: is this double counting every attack because we're using a cross
    # product?
    def horizontal_attacks
      attacks = 0

      pairs.each do |pair|
        attacks += 1 if (pair[0] == pair[1])
      end

      attacks
    end

    def diagonal_attacks
      attacks = 0

      queen_array = @queens.split(//).map { |i| Integer(i) }

      queen_array.each_with_index do |queen, column|
        for index in column..(queen_array.length - 1)
          if (index != column) and ((queen == queen_array[index] + (index-column)) or (queen == queen_array[index] - (index-column)))
            @log.debug "ADDING ATTACK on queen: #{queen} in #{column}\tpartner: #{queen_array[index]} in #{index}"
            attacks += 1
          end
        end
      end

      attacks
    end

    def attacks
      horizontal_attacks + diagonal_attacks
    end

    def valid_queen_positions(positions)
      if positions.match(/[1-8]{8}/)
        true
      else
        false
      end
    end

    def pairs
      queen_array = @queens.split(//)

      pairs = []

      for i in 0..(queen_array.length-1)
        for j in (i+1)..(queen_array.length-1)
          pairs << [ queen_array[i], queen_array[j] ]
        end
      end

      # queen_array.product(queen_array) do |first, second|
      #   pairs << [first, second]
      # end

      # diagonals = queen_array.zip(queen_array)

      # diagonals.each do |d|
      #   pairs.delete_at(pairs.index(d)) unless pairs.index(d).nil?
      # end

      pairs
    end
  end
end
