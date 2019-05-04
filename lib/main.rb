class TokenNode
    attr_accessor :position, :value

    def initialize(position, value = " ")
        @position = position
        @value = value
    end
end

class Player
    attr_reader :symbol

    def initialize(symbol)
        @symbol = symbol
    end
end

class GameBoard
    attr_reader :coordinates, :board

    def initialize
        @coordinates = create_coordinates
        @board = create_board
        display_board
    end
    
    def display_board
        puts ""
        print "|"
        @board[35..41].each { |token| print " #{token.value} |" }
        print "\n"
        print "|"
        @board[28..34].each { |token| print " #{token.value} |" }
        print "\n"
        print "|"
        @board[21..27].each { |token| print " #{token.value} |" }
        print "\n"
        print "|"
        @board[14..20].each { |token| print " #{token.value} |" }
        print "\n"
        print "|"
        @board[7..13].each { |token| print " #{token.value} |" }
        print "\n"
        print "|"
        @board[0..6].each { |token| print " #{token.value} |" }
        print "\n"
        puts ""
        puts "  1   2   3   4   5   6   7"
    end

    def make_turn
        input = gets.chomp.to_i
        @coordinates.each
    end

    def create_coordinates
        coordinates = []
        6.times do |index|
            column_index = index
            7.times do |index|
                position = []
                position << column_index
                position.unshift(index)
                coordinates << position
            end
        end
        coordinates
    end

    def create_board
        board = []
        @coordinates.each do |coordinate|
            token = TokenNode.new(coordinate)
            board << token
        end
        board
    end
end

def play_game
    game = GameBoard.new
end

play_game