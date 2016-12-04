class Station
  include Validation

  attr_accessor :name
  attr_reader :list_trains

  validate :name, :presence
  validate :type, :type, Station

  @@list_stations = []

  def initialize(name)
    @name = name
    @list_trains = []
    @type = self
    validate!
    @@list_stations << self
  end

  def self.all
    @@list_stations
  end

  def take_block
    @list_trains.each { |train| yield(train) }
  end

  def arrive_train(train)
    @list_trains << train
  end

  def depart_train(train)
    @list_trains.delete(train) if @list_trains
  end

  def list_types_trains(type)
    count_type = @list_trains.count { |train| train.type == type }
    puts "Количество поездов типа #{type}: #{count_type}"
  end
end
