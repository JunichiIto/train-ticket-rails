# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    ticket.fare >= calculate_fare(count_gate_from(ticket))
  end

  private

  def count_gate_from(ticket)
    (station_number - ticket.entered_gate.station_number).abs
  end

  def calculate_fare(gate_count)
    return 0 if gate_count == 0
    FARES[gate_count - 1]
  end
end
