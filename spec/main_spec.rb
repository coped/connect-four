require './lib/main'

describe Node do
    describe "#initialize" do
        let(:empty_node) { Node.new([0, 0]) }
        let(:played_node) { Node.new([0, 0], "X") }
            
        it "has a default value of \" \"" do
            expect(empty_node.value).to eql(" ")
        end
        it "has a value when provided as a parameter" do
            expect(played_node.value).to eql("X")
        end
    end
end

describe Player do
    subject { Player.new "X" }

    describe "#initialize" do
        it { is_expected.not_to be_nil }
        it "has a symbol when provided as a parameter" do
            expect(subject.symbol).to eql("X")
        end
    end
end

describe GameBoard do
    let(:game) { GameBoard.new }

    describe "#initialize" do
        it { is_expected.not_to be_nil }
    end
    describe "#display_board" do
        let(:player) { Player.new("X") }
        
        it "displays game board after each turn" do
            expect(game).to receive(:display_board)
            allow(game).to receive(:gets).and_return("1")
            game.make_turn(player)
        end
    end
    describe "#create_coordinates" do
        it "creates an array of 42 (7x6) coordinates" do
            size = 0
            game.coordinates.each { size += 1 }
            expect(size).to eql(42)
        end
    end
    describe "#create_board" do
        it "creates an array of nodes for each board coordinate" do
            size = 0
            game.board.each { size += 1 }
            expect(size).to eql(42)
        end
    end
    describe "#make_turn" do
        let(:player) { Player.new("X") }

        context "when placing a token in an empty column" do
            it "places a player token in the correct column" do
                allow(game).to receive(:gets).and_return("3")
                game.make_turn(player)

                expect(game.board[2].value).to eql("X")
            end
        end
        context "when placing a token in an occupied column" do
            it "places a player token above an existing token" do
                game.board[2].value = player.symbol

                allow(game).to receive(:gets).and_return("3")
                game.make_turn(player)

                expect(game.board[9].value).to eql("X")
            end
        end
    end
    describe "#check_win" do
        let(:player) { [Player.new("X"), Player.new("O")] }

        context "when winning horizontally" do
            before(:each) do
                3.times { |i| game.board[i].value = player[0].symbol }
    
                allow(game).to receive(:gets).and_return("4")
                game.make_turn(player[0])
            end
            it "ends the game" do
                expect(game.over).to eql(true)
            end
            it "correctly proclaims a winner" do
                expect(player[0].winner).to eql(true)
            end
        end
        context "when winning vertically" do
            before(:each) do 
                positions = [[0, 0], [0, 1], [0, 2]]

                game.board.each { |node| node.value = player[0].symbol if positions.include?(node.position) }

                allow(game).to receive(:gets).and_return("1")
                game.make_turn(player[0])
            end
            it "ends the game" do
                expect(game.over).to eql(true)
            end
            it "correctly proclaims a winner" do
                expect(player[0].winner).to eql(true)
            end
        end
        context "when winning diagonally to the right" do
            before(:each) do
                positions = [[0, 0], [1, 1], [2, 2], [3, 1], [3, 2]]
    
                game.board[3].value = player[1].symbol
                game.board.each { |node| node.value = player[0].symbol if positions.include?(node.position) }
    
                allow(game).to receive(:gets).and_return("4")
                game.make_turn(player[0])
            end
            it "ends the game" do
                expect(game.over).to eql(true)
            end
            it "correctly proclaims a winner" do
                expect(player[0].winner).to eql(true)
            end
        end
        context "when winning diagonally to the left" do
            before(:each) do
                positions = [[0, 2], [0, 1], [1, 2], [2, 1], [3, 0]]
    
                game.board[0].value = player[1].symbol
                game.board.each { |node| node.value = player[0].symbol if positions.include?(node.position) }
    
                allow(game).to receive(:gets).and_return("1")
                game.make_turn(player[0])
            end
            it "ends the game" do
                expect(game.over).to eql(true)
            end
            it "correctly proclaims a winner" do
                expect(player[0].winner).to eql(true)
            end
        end
        context "when gameboard is completely full" do
            before(:each) do
                positions = [[0, 0], [0, 1], [0, 2], [0, 3]]
                game.board.each { |node| node.value = "X" if positions[0..2].include?(node.position) }
                game.board.each_with_index { |node, index| node.value = index unless positions.include?(node.position) }

                allow(game).to receive(:gets).and_return("1")
            end
            it "calls a draw if no player has won" do
                game.make_turn(player[1])
                expect(game.draw).to eql(true)
            end
            it "correctly proclaims a winner if last move is winning move" do
                game.make_turn(player[0])
                expect(player[0].winner).to eql(true)
            end
        end
    end
end