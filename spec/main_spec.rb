require './lib/main'

describe TokenNode do
    describe "#initialize" do
        let(:empty_node) { TokenNode.new([0, 0]) }
        let(:played_node) { TokenNode.new([0, 0], "X") }
            
        it "has a default value of \" \"" do
            expect(empty_node.value).to eql(" ")
        end
        it "takes a value when provided as a parameter" do
            expect(played_node.value).to eql("X")
        end
    end
end

describe Player do
    subject { Player.new "X" }

    describe "#initialize" do
        it { is_expected.not_to be_nil }
        it "has a symbol" do
            expect(subject.symbol).to eql("X")
        end
    end
end

describe GameBoard do
    subject { GameBoard.new }

    describe "#initialize" do
        it { is_expected.not_to be_nil }
    end
    describe "#display_board" do
        it "displays game board" do
            expect(subject).to receive(:display_board)
            subject.display_board
        end
    end
    describe "#create_coordinates" do
        it "creates an array of 42 (7x6) coordinates" do
            size = 0
            subject.create_coordinates.each { size += 1 }
            expect(size).to eql(42)
        end
    end
    describe "#create_board" do
        it "creates an array of nodes for each board coordinate" do
            size = 0
            subject.create_board.each { size += 1 }
            expect(size).to eql(42)
        end
    end
    describe "#make_turn" do
        let(:player) { Player.new("X") }

        context "when placing a token in an empty column" do
            it "places a player token in the correct column" do
                allow(subject).to receive(:gets).and_return("3")
                subject.make_turn(player.symbol)
                expect(subject.board[2].value).to eql("X")
            end
        end
        context "when placing a token in an occupied column" do
            it "places a player token above an existing token" do
                allow(subject).to receive(:gets).and_return("3")
                subject.board[2].value = player.symbol
                subject.make_turn(player.symbol)
                expect(subject.board[9].value).to eql("X")
            end
        end
        context "when placing a token in a full column" do
            xit "rejects player input" do
                allow(subject).to receive(:gets).and_return("3")
                1.times { subject.make_turn(player.symbol) }
                expect(subject).to receive(:make_turn)
                subject.make_turn(player.symbol)
            end
        end
    end
end

describe "#play_game" do
end