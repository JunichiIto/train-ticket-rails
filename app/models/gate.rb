# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    entered_gate = ticket.entered_gate
    distance = distance_to(entered_gate)
    return false if distance == 0
    FARES[distance - 1] <= ticket.fare
  end

  def distance_to(to_gate)
    (station_number - to_gate.station_number).abs
  end
end
