# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    if fare = calc_fare(ticket)
      if fare <= ticket.fare
        true
      else
        ticket.errors[:base] << '降車駅 では降車できません。'
        false
      end
    else
      ticket.errors[:base] << '降車駅 では降車できません。'
      false
    end
  end

  def calc_fare(ticket)
    entered_station_num = Gate.find(ticket.entered_gate_id).station_number
    distance = (station_number - entered_station_num).abs
    if distance == 0
      false
    elsif distance == 1
      Gate::FARES[0]
    elsif distance == 2
      Gate::FARES[1]
    end
  end
end
