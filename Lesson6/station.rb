class Station
  attr_accessor :name
  attr_reader :list_trains

  @@list_stations = []

  def initialize(name)
    @name = name
    @list_trains = []
    @@list_stations << self
    validate!
  end

  def self.all
    @@list_stations
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

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Название станции не может быть пустым" if name == ''
    true
  end

end