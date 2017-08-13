# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    result = count_moving_station(ticket).abs
    return false if result.zero?

    if result < 2 || ticket.fare > FARES.first
      true
    else
      false
    end
  end

  def count_moving_station(ticket)
    entered_gate = Gate.find(ticket.entered_gate_id)
    entered_station_number = entered_gate.station_number
    exited_station_number = self.station_number
    exited_station_number - entered_station_number
  end

end
