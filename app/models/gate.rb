# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  # TODO
  def exit?(ticket)
    distance = (station_number - ticket.entered_gate.station_number).abs
    distance == 0 ? false : (ticket.fare >= FARES[distance - 1])
  end
end
