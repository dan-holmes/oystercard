class Oystercard
  LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    new_balance = @balance + amount
    raise "You cannot store more than #{LIMIT} pounds." if new_balance > 90
    @balance = new_balance
  end

  def deduct(amount)
    new_balance = @balance - amount
    @balance = new_balance
  end
end
