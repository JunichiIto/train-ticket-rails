# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    ride_section = ride_section(ticket.entered_gate)
    ticket.pay_enough?(ride_section)
  end

  private

  def ride_section(entered_gate)
    (entered_gate.station_number - station_number).abs
  end
end
