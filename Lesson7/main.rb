class Main
  require_relative 'manufacturer'
  require_relative 'validation'
  require_relative 'train'
  require_relative 'cargo_train'
  require_relative 'passenger_train'
  require_relative 'wagon'
  require_relative 'cargo_wagon'
  require_relative 'passenger_wagon'
  require_relative 'route'
  require_relative 'station'

  class << self
    def start
      main_menu = { 1 => :create_station, 2 => :create_train, 3 => :edit_train, 4 => :list_all }
      text_menu = ['Добро пожаловать в главное меню управления железными дорогами =^.^=',
                   'Введите номер пункта меню:', '1. Создать станцию', '2. Создать поезд',
                   '3. Работать с существующим поездом', '4. Просмотреть все станции и поезда']
      puts text_menu
      print ' > '
      choice = $stdin.gets.strip.to_i

      if main_menu.key?(choice)
        Main.send(main_menu[choice])
      else
        puts 'Неправильный номер пункта меню.'
        exit
      end
    end

    def create_station
      @stations ||= {}
      @index_stations ||= 0

      loop do
        puts 'Для выхода из процедуры введите 0 (цифру ноль)'
        puts 'Для создания станции введите еe название:'
        print ' > '
        name = $stdin.gets.strip
        if name == '0'
          print_stations(@stations)
          start
        else
          @stations[@index_stations] = Station.new(name)
          @index_stations += 1
        end
      end
    rescue RuntimeError => e
      puts e.message
      retry
    end

    def create_train
      @trains ||= {}
      @index_trains ||= 0

      loop do
        train_menu = ['Выберите тип создаваемого поезда:', '1. Грузовой', '2. Пассажирский',
                      'Для выхода из процедуры просто нажмите Enter']
        puts train_menu
        print ' > '
        choice = $stdin.gets.strip.to_i

        case choice
        when 1
          create_cargo_train
        when 2
          create_passenger_train
        when 0
          start
        end
      end
    end

    def create_cargo_train
      puts 'Отлично, создаем грузовой поезд, введите его номер:'
      print ' > '
      begin
        number = $stdin.gets.strip
        @trains[@index_trains] = CargoTrain.new(number)
        @index_trains += 1
        puts "Поезд с номером #{number} создан."
      rescue RuntimeError => e
        puts e.message
        retry
      end
    end

    def create_passenger_train
      puts 'Отлично, создаем пассажирский поезд, введите его номер:'
      print ' > '
      begin
        number = $stdin.gets.strip
        @trains[@index_trains] = PassengerTrain.new(number)
        @index_trains += 1
        puts "Поезд с номером #{number} создан."
      rescue RuntimeError => e
        puts e.message
        retry
      end
    end

    def print_trains(trains)
      trains.each_value do |train|
        puts "Поезд № #{train.number}, Тип: #{train.type}, Количество вагонов: #{train.wagons.size}"
      end
    end

    def edit_train
      loop do
        train = select_train
        train_menu = ['1. Прицепить к поезду вагон.', '2. Отцепить от поезда вагон.',
                      '3. Отправить поезд на станцию', '4. Занять место/объем в вагоне']
        puts train_menu
        print ' > '
        choice = $stdin.gets.strip.to_i

        case choice
        when 0
          puts 'Неправильный номер пункта меню'
          start
        when 1
          create_wagon(train)
        when 2
          train.del_wagon
        when 3
          start if @stations.nil?
          move_to_station(train)
        when 4
          select_wagon(train)
        end
      end
    end

    def select_train
      puts 'У нас есть следующие поезда:'
      print_trains(@trains)
      puts 'Введите номер нужного поезда'
      print ' > '
      choice = $stdin.gets.strip

      train = Train.find(choice)

      if train
        puts "Выбран поезд #{train}"
        train
      else
        puts 'Поезд с таким номером не существует'
        start
      end
    end

    def create_wagon(train)
      if train.cargo?
        puts 'Создаем грузовой вагон, введите объем:'
        print ' > '
        volume = $stdin.gets.strip.to_i
        train.add_wagon(CargoWagon.new(volume))
      else
        puts 'Создаем пассажирский вагон, введите количество мест:'
        print ' > '
        seats = $stdin.gets.strip.to_i
        train.add_wagon(PassengerWagon.new(seats))
      end
    end

    def move_to_station(train)
      puts "У нас есть следующие станции: #{@stations}"
      puts 'Введите порядковый номер нужной станции (перед знаком =>)'
      print ' > '
      choice = $stdin.gets.strip.to_i

      if @stations.key?(choice)
        station = @stations[choice]
      else
        puts 'Станция с таким порядковым номером не существует'
        start
      end

      create_route(train)
      current_station = train.current_station
      current_station.depart_train(train) if current_station
      station.arrive_train(train)
    end

    def create_route(train)
      route = Route.new(@stations[@stations.keys.first], @stations[@stations.keys.last])
      @stations.each_value do |s|
        route.add_station(s) unless route.list_stations.include?(s)
      end
      train.route = route
    end

    def select_wagon(train)
      wagons = {}
      index_wagons = 0
      train.take_block do |w|
        wagons[index_wagons] = w
        index_wagons += 1
      end
      puts 'У нас есть следующие вагоны:'
      print_wagons(train)
      puts 'Введите номер нужного вагона'
      print ' > '
      choice = $stdin.gets.strip.to_i - 1

      if wagons.key?(choice)
        wagon = wagons[choice]
      else
        puts 'Вагон с таким порядковым номером не существует'
        start
      end
      take_seats_or_capacity(wagon)
    end

    def take_seats_or_capacity(wagon)
      if wagon.type == :cargo
        puts 'Введите объем, который хотите занять: '
        print ' > '
        volume = $stdin.gets.strip.to_i
        wagon.take_capacity(volume)
        puts "Занято: #{wagon.occupied_capacity}, Свободно: #{wagon.free_capacity}"
      else
        wagon.take_seat
        puts "Занято: #{wagon.occupied_seats}, Свободно: #{wagon.free_seats}"
      end
    end

    def list_all
      puts 'У нас есть следующие станции: '

      print_stations(@stations) unless @stations.nil?

      exit
    end

    def print_stations(stations)
      stations.each do |_k, station|
        puts "Станция #{station.name.upcase}. Расписание:"

        station.take_block do |train|
          puts "Поезд № #{train.number}, Тип: #{train.type}, Количество вагонов: #{train.wagons.size}"
          print_wagons(train) unless train.wagons.empty?
        end
        puts '========================================================'
      end
    end

    def print_wagons(train)
      i = 1
      train.take_block do |wagon|
        puts "Вагон №#{i}, #{wagon.type}"
        puts "Занято: #{wagon.type == :cargo ? wagon.occupied_capacity : wagon.occupied_seats}"
        puts "Свободно: #{wagon.type == :cargo ? wagon.free_capacity : wagon.free_seats}"
        puts '-------------'
        i += 1
      end
    end
  end
end

Main.start
