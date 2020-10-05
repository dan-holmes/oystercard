require "Oystercard"

describe Oystercard do
  describe "# balance" do
    it "has a balance" do
      expect(subject.balance).to eq 0
    end

    it "can add to its balance" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "cannot store more than 90 pounds" do
      error = "You cannot store more than 90 pounds."
      expect { subject.top_up(100) }.to raise_error error
    end

    it "can deduct money from its balance" do
      subject.top_up(10)
      subject.deduct(5)
      expect(subject.balance).to eq 5
    end
  end

  describe "# touch in/out" do
  end
end
