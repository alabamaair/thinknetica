# Класс Station (Станция):

# Имеет название, которое указывается при ее создании
# station1 = Station.new('First Station')

# Может принимать поезда (по одному за раз)
# station1.arrive_train(train1)

# Может показывать список всех поездов на станции, находящиеся в текущий момент
# station1.list_trains

# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# station1.list_types_trains

# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
# station1.depart_train(train1)

class Station
  
  attr_writer :name
  attr_reader :list_trains

  def initialize(name)
    @name = name
    @list_trains = []
  end

  def arrive_train(train)
    @list_trains << train
  end

  def depart_train(train)
    @list_trains.delete(train) if @list_trains
  end

  def list_types_trains
    count_cargo = @list_trains.count { |train| train.type == :cargo }
    count_passenger = @list_trains.count { |train| train.type == :passenger }
    puts "Количество пассажирских поездов: #{count_passenger}"
    puts "Количество грузовых поездов: #{count_cargo}"
  end

end
