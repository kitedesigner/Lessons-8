module MessageModule
  ROUTE_LIST_MESSAGE = 'Список маршрутов: '.freeze
  ENTER_ANOTHER_VALUE = 'Введите другое значение: '.freeze
  SEPARATOR_STRING = '==='.freeze
  SELECT_NUMBER = 'Выберите номер :'.freeze
  TO_EXIT_APPLICATION_0 = '0 - для выхода из приложения'.freeze

  EXIT = 0
  EXIT.freeze

  def choices_list(*options, extra_lines)
    puts 'Введите:'
    number = 1
    options[0].each do |option|
      puts "#{number} - #{option}"
      number += 1
    end

    puts TO_EXIT_APPLICATION_0 if extra_lines
    print '> ' if extra_lines
  end

  def enter_another_value
    print ENTER_ANOTHER_VALUE # 'Введите другое значение: '
  end
end
