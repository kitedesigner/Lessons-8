require_relative "print_objects.rb"
require_relative "message_module.rb"

module Common
  include PrintObjects
  include MessageModule

  def select_from_list(array)
    puts SELECT_NUMBER
    number = gets.to_i
    array[number]
  end

  def wagons_list(train)
    puts "Список вагонов поезда #{train.number}:"
    train.wagons.each_with_index do |wagon, _index|
      wagon_info(wagon)
    end
  end

  def wagon_info(wagon)
    output_type = space_type(wagon.type)
    puts "Вагон номер: #{wagon.number}"
    puts "Количество #{output_type[:available_space]}: #{wagon.available_space},
      количество #{output_type[:reserved_space]}: #{wagon.reserved_space}"
  end
end
