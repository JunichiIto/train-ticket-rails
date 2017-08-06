# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    section_number = calc_section_number(ticket)
    return false unless section_number >= 1
    ticket.fare >= calc_fare(section_number)
  end

  private
  def calc_section_number(ticket)
    (station_number - ticket.entered_gate.station_number).abs
  end

  def calc_fare(section_number)
    FARES[section_number - 1]
  end
end
