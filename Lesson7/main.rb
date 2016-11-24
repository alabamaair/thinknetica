class Main

  require_relative 'manufacturer'
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
      puts 'Добро пожаловать в главное меню управления железными дорогами =^.^='
      puts 'Введите номер пункта меню:'
      puts '1. Создать станцию'
      puts '2. Создать поезд'
      puts '3. Работать с существующим поездом'
      puts '4. Просмотреть все станции и поезда'
      print ' > '
      choice = $stdin.gets.strip.to_i

      case choice
        when 1
          create_station
        when 2
          create_train
        when 3
          edit_train
        when 4
          list_all
        else
          puts 'Неправильный номер пункта меню.'
          exit
      end
    end

    def create_station
      @stations ||= {}
      @index_stations ||= 0

      while true
        puts 'Для выхода из процедуры просто нажмите Enter, оставив название станции пустым'
        puts 'Для создания станции введите еe название:'
        print ' > '
        name = $stdin.gets.strip
        if name == ''
          puts "#{Station.all}" #@stations
          start
        else
          @stations[@index_stations] = Station.new(name)
          @index_stations += 1
        end
      end

    end

    def create_train
      @trains ||= {}
      @index_trains ||= 0

      while true
        puts 'Выберите тип создаваемого поезда:'
        puts '1. Грузовой'
        puts '2. Пассажирский'
        puts 'Для выхода из процедуры просто нажмите Enter'
        print ' > '
        choice = $stdin.gets.strip.to_i

        case choice
          when 1
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
          when 2
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
          when 0
            puts @trains
            start
        end
      end
    end

    def edit_train

      while true
        puts "У нас есть следующие поезда: #{@trains}"
        puts 'Введите порядковый номер нужного поезда (перед знаком =>)'
        print ' > '
        choice = $stdin.gets.strip.to_i

        if @trains.has_key?(choice)
          train = @trains[choice]
        else
          puts 'Поезд с таким номером не существует'
          start
        end

        puts "Выбран поезд #{train}"
        puts '1. Прицепить к поезду вагон.'
        puts '2. Отцепить от поезда вагон.'
        puts '3. Отправить поезд на станцию'
        puts '4. Занять место/объем в вагоне'
        print ' > '
        choice = $stdin.gets.strip.to_i

        case choice
          when 0
            puts 'Неправильный номер пункта меню'
            start
          when 1
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
          when 2
            train.del_wagon
          when 3
            puts "У нас есть следующие станции: #{@stations}"
            puts 'Введите порядковый номер нужной станции (перед знаком =>)'
            print ' > '
            choice = $stdin.gets.strip.to_i

            if !@stations.nil? && @stations.has_key?(choice)
              station = @stations[choice]
            else
              puts 'Станция с таким порядковым номером не существует'
              start
            end

            station.arrive_train(train)
          when 4
            wagons = {}
            index_wagons = 0
            train.take_block { |w| wagons[index_wagons] = w; index_wagons += 1 }
            puts "У нас есть следующие вагоны: #{wagons}"
            puts 'Введите порядковый номер нужного вагона (перед знаком =>)'
            print ' > '
            choice = $stdin.gets.strip.to_i

            if wagons.has_key?(choice)
              wagon = wagons[choice]
            else
              puts 'Вагон с таким порядковым номером не существует'
              start
            end

            if wagon.type == :cargo
              puts "Введите объем, который хотите занять: "
              print ' > '
              volume = $stdin.gets.strip.to_i
              wagon.take_capasity(volume)
              puts "Занято объема: #{wagon.occupied_capasity}, Свободно объема: #{wagon.free_capasity}"
            else
              wagon.take_seat
              puts "Занято мест: #{wagon.occupied_seats}, Свободно мест: #{wagon.free_seats}"
            end

        end
      end
    end

    def list_all
      puts "У нас есть следующие станции: "

      unless @stations.nil?
        @stations.each do |k, v|
          puts "Станция #{v.name.upcase} с поездами:"

          v.take_block do |t|
            puts " = Поезд № #{t.number}, Тип: #{t.type}, Количество вагонов: #{t.wagons.size}"
            i = 1
            if t.wagons.size > 0
              puts " == c вагонами:"

              t.take_block do |w|
                w.type == :cargo ? puts(" === Вагон № #{i}, Тип: #{w.type}, Занято объема: #{w.occupied_capasity}, Свободно объема: #{w.free_capasity}") : puts(" === Вагон № #{i}, Тип: #{w.type}, Занято мест: #{w.occupied_seats}, Свободно мест: #{w.free_seats}")
                i += 1
              end

            end
          end

        end
      end

      exit
    end
  end

end

Main.start