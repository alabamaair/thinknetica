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

  def list_types_trains(type)
    count_type = @list_trains.count { |train| train.type == type }
    puts "Количество поездов типа #{type}: #{count_type}"
  end

end