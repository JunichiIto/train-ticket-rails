# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    ticket.fare >= calculate_fare(ticket)
  end

  def calculate_fare(ticket)
    case calculate_boarding_section(ticket)
    when 1; Gate::FARES[0]
    when 2; Gate::FARES[1]
    else raise 'fare is not defined'
    end
  end

  def calculate_boarding_section(ticket)
    (station_number - ticket.entered_gate.station_number).abs
  end
end
