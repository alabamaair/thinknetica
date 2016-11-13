# Класс Route (Маршрут):

# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# route1 = Route.new(station1, station3)

# Может добавлять промежуточную станцию в список
# route1.add_station(station2)

# Может удалять промежуточную станцию из списка
# route1.remove_station(station2)

# Может выводить список всех станций по-порядку от начальной до конечной
# route1.list_stations

class Route

  attr_reader :list_stations

  def initialize(start_station,end_station)
    @start_station = start_station
    @end_station = end_station
    @list_stations = [@start_station, @end_station]
  end

  def add_station(station)
    @list_stations.insert(-2, station)
  end

  def remove_station(station)
    @list_stations.delete(station)
  end

end
