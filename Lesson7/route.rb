class Route
  attr_reader :list_stations

  def initialize(start_station, end_station)
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
