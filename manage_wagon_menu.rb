require_relative "common.rb"
require_relative "wagon.rb"
require_relative "passenger_wagon.rb"
require_relative "cargo_wagon.rb"
require_relative "message_module"

module ManageWagon
  include Common
  include MessageModule

  RESERVE_SPACE = [
    'забронировать место',
    'завершить бронирование'
  ].freeze

  SEAT_SUCCESSFULLY_TAKEN = 'Бронирование места прошло успешно.'.freeze
  VOLUME_SUCCESSFULLY_TAKEN = 'Объём успешно забронирован.'.freeze

  def manage_wagon(wagon)
    loop do
      choices_list(RESERVE_SPACE, false)
      case gets.to_i
      when 1 then user_input_seats(wagon)
      when 2 then return
      else
        enter_another_value
      end
    end
  end

  def user_input_seats(wagon)
    user_taken_seats_volume(wagon)
    successfully_taken(wagon)
  end

  def user_taken_seats_volume(wagon)
    if wagon.is_a?(CargoWagon)
      puts ENTER_WAGON_VOLUME
      volume = gets.to_i
      wagon.reserve_space(volume)
    else
      wagon.reserve_space
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def successfully_taken(wagon)
    puts wagon.type == :cargo ? VOLUME_SUCCESSFULLY_TAKEN : SEAT_SUCCESSFULLY_TAKEN
    wagon_info(wagon)
  end

  def space_type(type)
    if type == :cargo
      { available_space: 'свободного объёма', reserved_space: 'занятого объёма' }
    else
      { available_space: 'свободных мест', reserved_space: 'занятых мест' }
    end
  end
end
