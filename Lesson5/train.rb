class Train
  include Manufacturer

  attr_reader :speed
  attr_accessor :route
  attr_reader :index_station
  attr_reader :type
  attr_reader :number

  @@trains = []

  def initialize(params = {})
    @number = params[:number] || 10.times.map { [*'0'..'9', *'a'..'z'].sample }.join
    @index_station = 0
    @speed = 0
    @list_wagons = []
    @@trains << self
  end

  def self.find(number)
    @@trains.find { |train| number == train.number }
  end

  def add_wagon(wagon)
    if stopped?
      self.type == wagon.type ? @list_wagons << wagon : puts('Типы поезда и вагона не совпадают.')
    else
      puts 'Сначала остановите поезд!'
    end
  end

  def del_wagon
    if stopped?
      @list_wagons.size > 0 ? @list_wagons.pop : puts('У поезда уже нет ни одного вагона.')
    else
      puts 'Сначала остановите поезд!'
    end
  end

  def wagons
    @list_wagons
  end

  def go(speed)
    speed > 0 ? self.speed += speed : puts('Введите корректное число для набора скорости.')
  end

  def stop
    @speed = 0
  end

  def current_station
    return unless has_route?
    @route.list_stations[@index_station]
  end

  def next_station
    return unless has_route?
    @index_station < @route.list_stations.count ? @route.list_stations[@index_station + 1] : puts('Поезд в конце маршрута.')
  end

  def previous_station
    return unless has_route?
    @index_station > 0 ? @route.list_stations[@index_station - 1] : puts('Поезд в начале маршрута.')
  end

  def move_to_next_station
    return unless has_route? && self.next_station
    @index_station += 1
    self.previous_station.depart_train(self)
    self.current_station.arrive_train(self)
  end

  def cargo?
    type == :cargo
  end

  def passenger?
    type == :passenger
  end

  private

  # скорость не должна меняться извне, а только через метод go, поэтому private
  attr_writer :speed

  # все методы ниже приватные, потому что используются только внутри класса для проверок, снаружи их вызывать не нужно
  def has_route?
    if @route
      true
    else
      puts 'Поезд не имеет маршрута.'
      false
    end
  end

  def stopped?
    @speed == 0
  end

end