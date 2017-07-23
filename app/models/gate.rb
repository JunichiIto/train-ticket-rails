# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    entered_gate = ticket.entered_gate
    return false if self.id == entered_gate.id
    fare_index = (self.station_number - entered_gate.station_number).abs - 1
    Gate::FARES[fare_index] <= ticket.fare
  end
end
