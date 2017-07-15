# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    return false if ticket.entered_gate == self
    ticket.fare >= calc_fare(ticket)
  end

  private

  def calc_fare(ticket)
    from = ticket.entered_gate.station_number
    to = station_number
    distance = (to - from).abs
    FARES[distance - 1]
  end
end
