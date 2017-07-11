# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190]

  with_options presence: true, uniqueness: true do
    validates :name
    validates :station_number
  end

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    ticket.exited_gate = self
    ticket.valid?(:exit)
  end
end
