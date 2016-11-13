# Класс Train (Поезд):

# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# train1 = Train.new('0001', :passenger, 20)

# Может набирать скорость
# train1.go(200)

# Может показывать текущую скорость
# train1.speed

# Может тормозить (сбрасывать скорость до нуля)
# train1.stop

# Может показывать количество вагонов
# train1.wagons

# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# train1.add_wagon
# train1.del_wagon

# Может принимать маршрут следования (объект класса Route)
# train1.route = route1

# Может перемещаться между станциями, указанными в маршруте.
# train1.station = station1
# train1.move_to_next_station

# Показывать предыдущую станцию, текущую, следующую, на основе маршрута
# train1.previous_station
# train1.current_station
# train1.next_station

class Train

  attr_accessor :speed
  attr_reader :wagons
  attr_reader :type

  attr_accessor :route
  attr_accessor :station

  def initialize(number,type,wagons)
    @number = number
    @type = type
    @wagons = wagons 
  end

  def add_wagon
    if @speed == 0
      @wagons += 1
    else
      puts "Сначала остановите поезд!"
    end
  end

  def del_wagon
    if @speed == 0
      @wagons -= 1
    else
      puts "Сначала остановите поезд!"
    end
  end

  def type
    @type
  end

  def go(speed)
    self.speed = speed
  end

  def stop
    self.speed = 0
  end

  def current_station
    @station
  end

  def next_station
    index_next_station = self.route.list_stations.index(@station) + 1
    if index_next_station < self.route.list_stations.count
      next_st = self.route.list_stations[index_next_station]
    else
      puts "Поезд в конце маршрута."
    end
  end

  def previous_station
    if self.route.list_stations.index(@station) > 0
      index_prev_st = self.route.list_stations.index(@station) - 1
      prev_st = self.route.list_stations[index_prev_st]
    else
      puts "Поезд в начале маршрута."
    end
  end

  def move_to_next_station
    if self.next_station
      self.station.depart_train(self)
      self.station = next_station
      self.station.arrive_train(self)
    end
  end

end
