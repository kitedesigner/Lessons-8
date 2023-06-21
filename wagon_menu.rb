require_relative "common.rb"
require_relative "wagon.rb"
require_relative "passenger_wagon.rb"
require_relative "cargo_wagon.rb"
require_relative "message_module.rb"
require_relative "wagon_menu.rb"

module WagonMenu
  include Common
  include MessageModule
  include ManageWagon

  WAGON_ADD_UNHOOK_MENU_LIST = [
    'добавить вагон',
    'отцепить вагон',
    'список вагонов',
    'любое значение для возврата в корневое меню'
  ].freeze

  ENTER_WAGON_VOLUME = 'Введите объём вагона:'.freeze
  ENTER_WAGON_SEATS = 'Введите количество пассажирских мест'.freeze
  ENTER_NUMBER_WAGON_TRAIN = 'Введите номер вагона поезда: '.freeze
  BACK_TO_TRAIN_MANAGEMENT = 'вернуться к управлению поездами'.freeze

  def wagons_menu_train
    loop do
      choices_list(WAGON_ADD_UNHOOK_MENU_LIST, BACK_TO_TRAIN_MANAGEMENT)
      case gets.to_i
      when 1 then add_wagon_train(select_train)
      when 2 then remove_wagon_train(select_train)
      when 3 then wagons_list(select_train)
      else break
      end
    end
  end

  def create_wagon_train(train, number)
    puts train.type == :cargo ? ENTER_WAGON_VOLUME : ENTER_WAGON_SEATS
    volume = gets.to_i
    train.type == :cargo ? CargoWagon.new(number, volume) : PassengerWagon.new(number, volume)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def manage_wagons_menu(wagons)
    puts ENTER_NUMBER_WAGON_TRAIN
    wagon = select_wagon(gets.to_i, wagons)
    if wagon.nil?
      puts enter_another_value
      raise 'Вагон не выбран'
    end
    manage_wagon(wagon)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def select_wagon(number, wagons)
    wagons.detect { |wagon| wagon.number == number }
  end

  def add_wagon_train(train)
    enter_number_wagon_message
    number = gets.to_i
    wagon = create_wagon_train(train, number)
    train.add_wagon(wagon)
    add_wagon(wagon)
  end

  def remove_wagon_train(train)
    enter_number_wagon_message
    wagons_list(train)
    wagon = select_from_list(train.wagons)
    train.remove_wagon(wagon)
    wagons_list(train)
  end

  def add_wagon(wagon)
    @wagons << wagon
  end

  def enter_number_wagon_message
    puts ENTER_NUMBER_WAGON_TRAIN # 'Введите номер вагона поезда: '
  end
end
