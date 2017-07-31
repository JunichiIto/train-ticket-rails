# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    section = (station_number - ticket.entered_gate.station_number).abs
    price = FARES[section - 1]
    ticket.fare - price >= 0
  end
end
