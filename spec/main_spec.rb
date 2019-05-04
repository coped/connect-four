require './lib/main'

describe TokenNode do
    context "when initialized" do
        let(:empty_token) { TokenNode.new([0, 0]) }
        let(:played_token) { TokenNode.new([0, 0], "X") }
            
        it "has a default value of \" \"" do
            expect(empty_token.value).to eql(" ")
        end
        it "takes and stores a provided value" do
            expect(played_token.value).to eql("X")
        end
    end
end

describe Player do
    subject { Player.new "X" }

    describe "#initialize" do
        context "when initializing player object" do
            it { is_expected.not_to be_nil }
        end
    end
end

describe GameBoard do
    subject {GameBoard.new}

    describe "#initialize" do
        context "when initializing GameBoard object" do
            it { is_expected.not_to be_nil }
        end
    end
    describe "#display_board" do
        context "when calling #display_board between turns" do
            it "displays game board" do
                expect(subject).to receive(:display_board)
                subject.display_board
            end
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
            subject.create_board.each { size += 1}
            expect(size).to eql(42)
        end
    end
end

describe "#play_game" do
end