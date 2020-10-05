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

    it "can deducted from" do
      subject.top_up(10)
      subject.deduct(5)
      expect(subject.balance).to eq 5
    end
  end

  describe "touch in/out" do
    it "knows if it's in a journey" do
      is_expected.not_to be_in_journey
    end

    context "when it has more than the minimum fare" do
      before { subject.top_up(10) }
      it "can touch in" do
        subject.touch_in
        is_expected.to be_in_journey
      end

      it "can touch out" do
        subject.touch_in
        subject.touch_out
        is_expected.not_to be_in_journey
      end
    end

    context "when it has less than the minimum fare" do
      it "stops you touching in" do
        error = "You need at least #{Oystercard::MINIMUM_FARE} pound to touch in."
        expect { subject.touch_in }.to raise_error error
      end
    end
  end
end
