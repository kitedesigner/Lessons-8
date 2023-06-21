require_relative "manufacturer.rb"

class Wagon
  attr_reader :number, :type, :reserved_space

  def initialize(number, type, volume)
    @number = number
    @type = type
    @volume = volume
    @reserved_space = 0
  end

  def available_space
    @volume - reserved_space
  end

  def reserve_space(amount)
    @reserved_space += amount
  end
end
