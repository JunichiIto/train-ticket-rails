# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    distance = distance_from(ticket.entered_gate)
    distance > 0 && FARES[distance - 1] <= ticket.fare
  end

  private

  def distance_from(other_gate)
    (station_number - other_gate.station_number).abs
  end
end
