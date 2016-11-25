class CargoWagon < Wagon
  attr_reader :free_capacity
  attr_reader :occupied_capacity

  def initialize(capacity)
    @type = :cargo
    @capacity = capacity.to_i
    @free_capacity = capacity.to_i
    @occupied_capacity = 0
  end

  def take_capacity(volume)
    return if @occupied_capacity >= @capacity
    @occupied_capacity += volume.to_i
    @free_capacity = @capacity - @occupied_capacity
    if @occupied_capacity > @capacity
      @free_capacity = 0
      @occupied_capacity = @capacity
    end
  end
end
