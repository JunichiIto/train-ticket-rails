# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    fare_rule = FareRule.find_by_gates(ticket.entered_gate, self)
    fare_rule ? ticket.fare == fare_rule.money : false
  end
end
