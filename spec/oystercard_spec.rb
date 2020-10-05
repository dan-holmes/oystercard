require "Oystercard"

describe Oystercard do
  describe "balance" do
    it "starts at 0" do
      expect(subject.balance).to eq 0
    end

    it "can be can added to" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "has a limit" do
      subject.top_up(Oystercard::LIMIT)
      error = "You cannot store more than #{Oystercard::LIMIT} pounds."
      expect { subject.top_up(1) }.to raise_error error
    end
  end

  it "knows if you're in a journey" do
    is_expected.not_to be_in_journey
  end

  context "when balance is above minimum" do
    before { subject.top_up(10) }
    context "when not in a journey" do
      describe "#touch_in" do
        it "starts your journey" do
          subject.touch_in
          should be_in_journey
        end
      end
    end
    context "when in a journey" do
      before { subject.touch_in }
      describe "#touch_out" do
        it "ends your journey" do
          subject.touch_out
          should_not be_in_journey
        end
        it "charges you money" do
          expect { subject.touch_out }.to change { subject.balance }.by (-Oystercard::MINIMUM_FARE)
        end
      end
    end
  end

  context "when balance is below minimum" do
    describe "#touch_in" do
      it "will not let you enter" do
        expect { subject.touch_in }.to raise_error "You need at least #{Oystercard::MINIMUM_FARE} pound to touch in."
      end
    end
  end
end
