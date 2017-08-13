# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    return false if ticket.entered_gate == self

    required_fare = fare_from(ticket.entered_gate)
    ticket.fare >= required_fare
  end

  private

  def fare_from(other_gate)
    distance = (other_gate.station_number - self.station_number).abs
    FARES[distance - 1]
  end
end
