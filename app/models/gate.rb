# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    distance = self.relative_distance_between_another(ticket.entered_gate)
    return false if distance.zero?
    return ticket.fare >= FARES[distance-1]
  rescue
    false
  end

  protected
  def relative_distance_between_another(gate)
    (gate.station_number - self.station_number).abs
  end
end
