require_relative "common.rb"
require_relative "train.rb"
require_relative "passenger_train.rb"
require_relative "cargo_train.rb"
require_relative "message_module.rb"

module TrainsMenu
  include Common
  include MessageModule

  TRAINS_MENU_LIST = [
    'создать новый поезд',
    'назначить маршрут поезду',
    'управление вагонами',
    'переместить поезд по маршруту',
    'любое значение для возврата в корневое меню'
  ].freeze

  MOVE_TRAIN_MENU_LIST = [
    'отправить на следующую станцию',
    'отправить на предыдущую станцию',
    'любое значение для возврата в корневое меню'
  ].freeze

  CREATE_TRAIN_BY_TYPE_MENU_LIST = [
    'пассажирский поезд', 'грузовой поезд'
  ].freeze

  CREATE_TRAIN_MESSAGE = 'Сначало создайте поезд.'.freeze
  ENTER_NAME_NEW_TRAIN_MESSAGE = 'Введите наименование нового поезда: '.freeze
  TRAIN_LIST_MESSAGE = 'Список поездов: '.freeze
  ENTER_CORRECTION_NUMBER_TRAIN = 'Введите правильный номер поезда и повторите попытку.'.freeze
  ENTER_ANOTHER_NUMBER_MESSAGE = 'Такое наименование существует, введите другое значение: '.freeze
  LIST_OF_TRAINS_MESSAGE = 'Общий список поездов:'.freeze

  def trains_menu
    loop do
      choices_list(TRAINS_MENU_LIST, false)
      case gets.to_i
      when 1 then create_train
      when 2 then set_train_route
      when 3 then wagons_menu_train
      when 4 then move_train_menu
      else break
      end
    end
  end

  def move_train_menu
    loop do
      train = select_train
      choices_list(MOVE_TRAIN_MENU_LIST, true)
      case gets.to_i
      when 1 then train.move_to_next_station
      when 2 then train.move_to_previous_station
      else break
      end
    end
  end

  def create_train
    print ENTER_NAME_NEW_TRAIN_MESSAGE # 'Введите наименование нового поезда: '
    number = gets.chomp
    return print ENTER_ANOTHER_NUMBER_MESSAGE if train_exist?(number)

    create_train_by_type(number)
    train_created_message(number)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train_by_type(number)
    choices_list(CREATE_TRAIN_BY_TYPE_MENU_LIST, false)
    case gets.to_i
    when 1 then @trains << PassengerTrain.new(number)
    when 2 then @trains << CargoTrain.new(number)
    else enter_another_value
    end
  end

  def set_train_route
    puts TRAIN_LIST_MESSAGE
    trains_list
    train = select_from_list(@trains)
    puts ROUTE_LIST_MESSAGE
    routes_list
    route = select_from_list(@routes)
    return if train.nil? || route.nil?

    train.add_route(route)
  end

  def select_train
    puts TRAIN_LIST_MESSAGE
    trains_list
    selected_train = select_from_list(@trains)
    raise ENTER_CORRECTION_NUMBER_TRAIN if selected_train.nil?

    selected_train
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def train_exist?(number)
    !!@trains.detect { |train| train.number == number }
  end

  def train_created_message(number)
    blank_line
    puts "Поезд #{number} успешно создан."
  end
end
