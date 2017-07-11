# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    return false if ticket.entered_gate == self
    fare_from(ticket.entered_gate) <= ticket.fare
  end

  def distance_from(departure)
    (self.station_number - departure.station_number).abs - 1
  end

  def fare_from(destination)
    FARES[distance_from(destination)]
  end
end
