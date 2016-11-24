class Train
  include Manufacturer

  attr_reader :speed
  attr_accessor :route
  attr_reader :index_station
  attr_reader :type
  attr_reader :number

  @@trains = {}

  NUMBER_FORMAT = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/

  def initialize(number)
    @number = number.to_s
    @index_station = 0
    @speed = 0
    @list_wagons = []
    validate!
    @@trains[@number] = self
  end

  def self.all
    @@trains
  end

  def self.find(number)
    @@trains[number]
  end

  def take_block(&block)
    @list_wagons.each { |wagon| yield(wagon) }
  end

  def add_wagon(wagon)
    if stopped?
      self.type == wagon.type ? @list_wagons << wagon : false
    else
      false
    end
  end

  def del_wagon
    if stopped?
      @list_wagons.size > 0 ? @list_wagons.pop : false
    else
      false
    end
  end

  def wagons
    @list_wagons
  end

  def print_wagons
    @list_wagons.each_with_index { |w, index| puts "#{index} => #{w}" }
  end

  def go(speed)
    speed > 0 ? self.speed += speed : false
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
    @index_station < @route.list_stations.count ? @route.list_stations[@index_station + 1] : false
  end

  def previous_station
    return unless has_route?
    @index_station > 0 ? @route.list_stations[@index_station - 1] : false
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

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Номер поезда не может быть короче 5 символов" if number.to_s.size < 5
    raise "Номер поезда имеет неправильный формат" if number !~ NUMBER_FORMAT
    true
  end

  private

  # скорость не должна меняться извне, а только через метод go, поэтому private
  attr_writer :speed

  # все методы ниже приватные, потому что используются только внутри класса для проверок, снаружи их вызывать не нужно
  def has_route?
    !@route.nil?
  end

  def stopped?
    @speed == 0
  end

end