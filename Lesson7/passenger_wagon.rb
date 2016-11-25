class PassengerWagon < Wagon
  attr_reader :occupied_seats
  attr_reader :free_seats

  def initialize(seats)
    @seats = seats.to_i
    @free_seats = seats.to_i
    @occupied_seats = 0
    @type = :passenger
  end

  def take_seat
    return if @occupied_seats >= @seats
    @free_seats -= 1
    @occupied_seats += 1
  end
end
