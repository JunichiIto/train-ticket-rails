# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    station_distance = (station_number - ticket.entered_gate.station_number).abs
    return false if ticket.fare == 150 && station_distance == 2
    true
  end
end
