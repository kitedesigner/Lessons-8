class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)

  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)

  end
end
