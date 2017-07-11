class Section
  attr_reader :boarding, :alighting

  def initialize(ticket)
    @boarding  = ticket.entered_gate || Gate.new
    @alighting = ticket.exited_gate  || Gate.new
  end

  def distance
    (boarding.station_number.to_i - alighting.station_number.to_i).abs
  end

  # NOTE: Gateの定数に依存するので脆い
  def fare
    Gate::FARES[distance - 1] || 0
  end

  def same_stations?
    boarding.station_number == alighting.station_number
  end
end
