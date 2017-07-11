# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190]

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    enough_fare?(ticket) && different_station?(ticket)
  end

  def enough_fare?(ticket)
    needed_fare(ticket.entered_gate) <= ticket.fare
  end

  private

  def different_station?(ticket)
    name != ticket.entered_gate.name
  end

  def needed_fare(entered_gate)
    FARES[(station_number - entered_gate.station_number).abs - 1]
  end
end
