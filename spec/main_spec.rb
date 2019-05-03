require './lib/main'

describe Player do
    subject {Player.new "X"}

    describe "#initialize" do
        context "when initializing player object" do
            it {is_expected.not_to be_nil}
        end
    end
end

describe GameBoard do
    subject {GameBoard.new}

    describe "#initialize" do
        context "when initializing GameBoard object" do
            it {is_expected.not_to be_nil}
        end
    end
    describe "#display_board" do
        context "when calling #display_board between turns" do
            it "should display game board" do
                expect(subject).to receive(:display_board)
                subject.display_board
            end
        end
    end
end

describe "#main" do
end