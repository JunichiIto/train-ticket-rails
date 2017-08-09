# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    raise if ticket.nil?
    gate_count = count_gate_from(ticket)
    return false if gate_count.zero?
    ticket.fare >= calculate_fare(gate_count)
  end

  private

  def count_gate_from(ticket)
    (station_number - ticket.entered_gate.station_number).abs
  end

  def calculate_fare(gate_count)
    return 0 if gate_count.zero?
    FARES[gate_count - 1]
  end
end
