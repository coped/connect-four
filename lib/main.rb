class TokenNode
    attr_reader :position
    attr_accessor :value

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
    attr_reader :coordinates, :board, :over

    def initialize
        @coordinates = create_coordinates
        @board = create_board
        @over = false
    end
    
    def display_board
        puts ""
        print "|"
        @board[35..41].each { |node| print " #{node.value} |" }
        print "\n"
        print "|"
        @board[28..34].each { |node| print " #{node.value} |" }
        print "\n"
        print "|"
        @board[21..27].each { |node| print " #{node.value} |" }
        print "\n"
        print "|"
        @board[14..20].each { |node| print " #{node.value} |" }
        print "\n"
        print "|"
        @board[7..13].each { |node| print " #{node.value} |" }
        print "\n"
        print "|"
        @board[0..6].each { |node| print " #{node.value} |" }
        print "\n"
        puts ""
        puts "  1   2   3   4   5   6   7"
        puts "_____________________________"
        puts ""
    end

    def make_turn(player_symbol)
        input = gets.chomp.to_i - 1
        valid_input = false
        @board.each do |node|
            if input == node.position[0] && node.value == " "
                node.value = player_symbol 
                valid_input = true
                break
            end
        end
        unless valid_input
            puts "\nInvalid input."
            make_turn(player_symbol)
        end
        display_board if valid_input
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
            node = TokenNode.new(coordinate)
            board << node
        end
        board
    end
end

def play_game
    player1 = Player.new("X")
    player2 = Player.new("O")
    game = GameBoard.new
    
    game.display_board
    until game.over
        puts "Player 1's turn (X):"
        game.make_turn(player1.symbol)

        break if game.over

        puts "Player 2's turn (O):"
        game.make_turn(player2.symbol)
    end
end

play_game if __FILE__ == $0