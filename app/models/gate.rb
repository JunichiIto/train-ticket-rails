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

  #チケットから駅番号を検索
  def self.find_station_num(ticket)
    find(ticket.entered_gate_id).station_number
  end

  #距離の計算
  def calc_distance(ticket)
    station_number - Gate.find_station_num(ticket)
  end

  #運賃を算出
  def calc_fare(ticket)
    if calc_distance(ticket) == 0
      false
    elsif calc_distance(ticket).abs == 1
      Gate::FARES[0]
    elsif calc_distance(ticket).abs == 2
      Gate::FARES[1]
    end
  end
end
