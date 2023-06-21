require_relative "common.rb"
require_relative "message_module.rb"
require_relative "stations_menu.rb"
require_relative "route_menu.rb"
require_relative "trains_menu.rb"
require_relative "wagon_menu.rb"
require_relative "print_objects.rb"

class MainMenu
  include Common
  include MessageModule
  include PrintObjects
  include StationsMenu
  include RouteMenu
  include TrainsMenu
  include WagonMenu

  SHOW_MENU_LIST = [
    'управление станциями',
    'управление поездами',
    'управление маршрутами',
    'резервировать место в вагоне'
  ].freeze

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
  end

  def start
    loop do
      show_menu
    end
  end

  private

  def show_menu
    choices_list(SHOW_MENU_LIST, true)
    case gets.to_i
    when 1 then stations_menu
    when 2 then trains_menu
    when 3 then route_menu
    when 4 then manage_wagons_menu(select_train.wagons)
    when EXIT then exit
    else enter_another_value
    end
  end
end
