class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    new_balance = @balance + amount
    raise "You cannot store more than #{LIMIT} pounds." if new_balance > 90
    @balance = new_balance
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "You need at least #{MINIMUM_FARE} pound to touch in." if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(1)
  end

  private

  def deduct(amount)
    new_balance = @balance - amount
    @balance = new_balance
  end
end
