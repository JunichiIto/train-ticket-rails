# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    need_fare_idx = (station_number - ticket.entered_gate.station_number).abs - 1
    FARES[need_fare_idx] <= ticket.fare
  end
end
