class Player
    def initialize symbol
        @symbol = symbol
    end
end

class GameBoard
    def initialize
        display_board
    end

    def display_board
        puts "BOARD"
    end
end

def main
    game = GameBoard.new
    game.display_board
end

main