class CargoWagon < Wagon
  attr_reader :free_capasity
  attr_reader :occupied_capasity

  def initialize(capasity)
    @type = :cargo
    @capasity = capasity.to_i
    @free_capasity = capasity.to_i
    @occupied_capasity = 0
  end

  def take_capasity(volume)
    return if @occupied_capasity >= @capasity
    @occupied_capasity = @occupied_capasity + volume.to_i
    @free_capasity = @capasity - @occupied_capasity
    if @occupied_capasity > @capasity
      @free_capasity = 0
      @occupied_capasity = @capasity
    end
  end


end