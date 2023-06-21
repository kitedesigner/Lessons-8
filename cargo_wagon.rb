class CargoWagon < Wagon
  DEFAULT_VOLUME = 10
  def initialize(number, volume = DEFAULT_VOLUME)
    super(number, :cargo, volume)
  end

  def reserve_space(amount)
    raise 'Недостаточно места.' if available_space - amount < 0

    super(amount)
  end
end
