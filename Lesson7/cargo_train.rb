class CargoTrain < Train

  NUMBER_FORMAT = /^[a-z]{3}-?[0-9]{2}$/i

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @type = :cargo
    super
  end
end
