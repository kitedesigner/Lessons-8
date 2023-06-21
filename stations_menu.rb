require_relative "common.rb"
require_relative "station.rb"
require_relative "message_module.rb"

module StationsMenu
  include Common
  include MessageModule

  STATIONS_MENU_LIST = [
    'создание станции',
    'список станций',
    'любое значение для возврата в корневое меню'
  ].freeze

  INPUT_NAME_STATION_MESSAGE = 'Введите название новой станции: '.freeze
  STATION_EXISTS_MESSAGE = 'Такая станция существует, введите другое значение: '.freeze
  ENTER_ID_FIRST_STATION = 'Введите номер первой станции: '.freeze
  ENTER_ID_SECOND_STATION = 'Введите номер второй станции: '.freeze
  STATION_MANAGEMENT = 'Управление станциями:'.freeze

  def stations_menu
    loop do
      stations_menu_intro
      choices_list(STATIONS_MENU_LIST, false)
      case gets.to_i
      when 1 then create_station
      when 2 then stations_list
      else break
      end
    end
  end

  def create_station
    print INPUT_NAME_STATION_MESSAGE # 'Введите название новой станции: '
    name = gets.chomp
    return print STATION_EXISTS_MESSAGE if station_exist?(name)

    @stations << Station.new(name)
    station_created_message(name)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def select_stations
    print ENTER_ID_FIRST_STATION # 'Введите номер первой станции: '
    first_station = select_from_list(@stations)
    print ENTER_ID_SECOND_STATION # 'Введите номер второй станции: '
    last_station = select_from_list(@stations)
    [first_station, last_station]
  end

  def station_exist?(name)
    !!@stations.detect { |station| station.name == name }
  end

  def stations_menu_intro
    puts SEPARATOR_STRING
    puts STATION_MANAGEMENT # 'Управление станциями:'
  end

  def station_created_message(name)
    blank_line
    puts "Станция #{name} успешно создана."
  end
end
