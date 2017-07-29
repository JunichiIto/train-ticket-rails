# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    entered_gate = Gate.find(ticket.entered_gate_id)
    section = (self.station_number - entered_gate.station_number).abs
    ticket.fare >= FARES[section - 1]
  end
end
