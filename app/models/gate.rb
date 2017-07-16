# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    section_number = (ticket.entered_gate.station_number - station_number).abs

    case section_number
    when 1 then ticket.fare == 150
    when 2 then ticket.fare == 190
    else
      false
    end
  end
end
