# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = FareRule.map(&:money)

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    fare_rule = fare_rule_by_gate(ticket.entered_gate)
    fare_rule ? ticket.fare == fare_rule.money : false
  end

  private

  def fare_rule_by_gate(other_gate)
    number_of_section = number_of_section_by_gate(other_gate)
    FareRule.find { |f| f.number_of_section == number_of_section }
  end

  def number_of_section_by_gate(other_gate)
    (other_gate.station_number - station_number).abs
  end
end
