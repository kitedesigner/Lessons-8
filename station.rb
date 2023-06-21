require_relative "instance_counter.rb"

class Station
  include InstanceCounter

  attr_reader :trains, :name

  EMPTY_NAME_ERROR = 'Введено пустое имя'.freeze

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def accept_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def select_trains(type)
    trains.select { |train| train.type == type }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    raise EMPTY_NAME_ERROR if @name.nil?
  end
end
