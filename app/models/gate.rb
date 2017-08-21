# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    return false if self == ticket.entered_gate
    cost = calculate_cost(ticket.entered_gate, self)
    ticket[:fare] >= cost
  end

  private

  def calculate_cost(entered_gate, exit_gate)
    distance = calculate_distance(entered_gate.station_number, exit_gate.station_number)
    return FARES[distance-1]
  end

  def calculate_distance(entered_stnum, exit_stnum)
    (entered_stnum - exit_stnum).abs
  end
end
