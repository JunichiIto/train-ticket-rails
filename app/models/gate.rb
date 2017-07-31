# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    price = calculate(ticket)
    price > 0 && ticket.fare - price >= 0
  end

  private

  def calculate(ticket)
    section = (station_number - ticket.entered_gate.station_number).abs
    section > 0 ? FARES[section - 1] : 0
  end
end
