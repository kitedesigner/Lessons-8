module PrintObjects
  def stations_list
    @stations.each_with_index do |stations, index|
      puts "#{index} - Наименование станции - #{stations.name}"
    end
    blank_line
  end

  def routes_list
    routes = []
    @routes.each do |route|
      routes << "Маршрут номер #{@routes.index(route)}"
    end
    blank_line
    puts routes.join(', ')
  end

  def trains_list
    @trains.each_with_index do |train, index|
      print "#{index} - Наименование поезда - #{train.number}"
      print ", тип: #{train.type}"
      puts ", количество вагонов: #{train.wagons.size}"
    end
  end

  def blank_line
    
    puts ''
  end
end
