class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end
end
