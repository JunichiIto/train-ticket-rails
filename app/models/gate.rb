# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    return false if same_gate?(ticket.entered_gate)
    ticket.fare >= section_fare(ticket.entered_gate)
  end

  private

  def same_gate?(entered_gate)
    self == entered_gate
  end

  def section_fare(entered_gate)
    FARES[(station_number - entered_gate.station_number).abs - 1]
  end
end
