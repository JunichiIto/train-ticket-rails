# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    transportation_fare(ticket.entered_gate) <= ticket.fare
  end

  private

  def section(other_station_gate)
    (station_number - other_station_gate.station_number).abs
  end

  def transportation_fare(other_station_gate)
    FARES[section(other_station_gate) - 1]
  end
end
