module WinCheck
    def win?(board, parent, direction)
        result = false
        values = []
        4.times do |index|
            node = []
            case direction
            when "horizontal"
                node = board.select { |node| [parent.position[0] + index, parent.position[1]] == node.position }
            when "vertical"
                node = board.select { |node| [parent.position[0], parent.position[1] + index] == node.position }
            when "right_diag"
                node = board.select { |node| [parent.position[0] + index, parent.position[1] + index] == node.position }
            when "left_diag"
                node = board.select { |node| [parent.position[0] - index, parent.position[1] + index] == node.position }
            end
            node = node[0]
            break if node.nil?
            values << node.value if (0..7).include?(node.position[0]) && (0..6).include?(node.position[1])
        end
        result = true if values.all?(parent.value) && values.length == 4 && values.none?(" ")
        result
    end
end

class Node
    attr_reader :position
    attr_accessor :value

    def initialize(position, value = " ")
        @position = position
        @value = value
    end
end

class Player
    attr_reader :symbol
    attr_accessor :winner
    
    def initialize(symbol)
        @symbol = symbol
        @winner = false
    end
end

class GameBoard
    include WinCheck
    attr_reader :coordinates, :board, :over, :draw
    
    def initialize
        @coordinates = create_coordinates
        @board = create_board
        @over = false
        @draw = false
    end

    public
    
    def make_turn(player)
        input = gets.chomp.to_i - 1
        valid_input = false
        @board.each do |node|
            if input == node.position[0] && node.value == " "
                node.value = player.symbol 
                valid_input = true
                break
            end
        end
        unless valid_input
            puts "\nInvalid input."
            make_turn(player)
        end
        if valid_input
            display_board
            check_win(player)
        end
    end

    def check_win(player)
        @board.each do |node|
            if win?(@board, node, "horizontal") || win?(@board, node, "vertical") || win?(@board, node, "right_diag") || win?(@board, node, "left_diag")
                @over = true
                player.winner = true
                break
            end
        end

        player.winner = true if @over

        if @board.none?{ |node| node.value == " " } && @over == false
            @draw = true
            @over = true
        end
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

    private
    
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
            node = Node.new(coordinate)
            board << node
        end
        board
    end
end

def play_game
    player = [Player.new("X"), Player.new("O")]
    game = GameBoard.new
    
    game.display_board
    until game.over
        puts "Player 1's turn (#{player[0].symbol}):"
        game.make_turn(player[0])

        break if game.over

        puts "Player 2's turn (#{player[1].symbol}):"
        game.make_turn(player[1])
    end

    if game.draw
        puts "\nDRAW! GAME OVER."
    else
        puts player[0].winner ? "\nGAME OVER! PLAYER 1 WINS." : "\nGAME OVER! PLAYER 2 WINS."
    end
    puts ""
end

play_game if __FILE__ == $0