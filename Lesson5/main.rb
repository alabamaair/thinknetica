require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'route'
require_relative 'station'

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
      puts @stations
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
        number = $stdin.gets.strip
        @trains[@index_trains] = CargoTrain.new(number)
        @index_trains += 1
      when 2
        puts 'Отлично, создаем пассажирский поезд, введите его номер:'
        print ' > '
        number = $stdin.gets.strip
        @trains[@index_trains] = PassengerTrain.new(number)
        @index_trains += 1
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
      puts 'Поезд с таким порядковым номером не существует'
      start
    end

    puts "Выбран поезд #{train}"
    puts '1. Прицепить к поезду вагон.'
    puts '2. Отцепить от поезда вагон.'
    puts '3. Отправить поезд на станцию'
    print ' > '
    choice = $stdin.gets.strip.to_i

    case choice
      when 0
        puts 'Неправильный номер пункта меню'
        start
      when 1
        if train.cargo?
          train.add_wagon(CargoWagon.new)
        else
          train.add_wagon(PassengerWagon.new)
        end
      when 2
        train.del_wagon
      when 3
        puts "У нас есть следующие станции: #{@stations}"
        puts 'Введите порядковый номер нужной станции (перед знаком =>)'
        print ' > '
        choice = $stdin.gets.strip.to_i

        if @stations.has_key?(choice)
          station = @stations[choice]
        else
          puts 'Станция с таким порядковым номером не существует'
          start
        end

        station.arrive_train(train)

    end
  end
end

def list_all
  puts "У нас есть следующие станции: #{@stations}"
  puts "У нас есть следующие поезда: #{@trains}"
  exit
end

start