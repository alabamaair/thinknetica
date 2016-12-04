class PassengerTrain < Train

  NUMBER_FORMAT = /^[0-9]{3}-?[a-z]{2}$/i

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @type = :passenger
    super
  end
end
