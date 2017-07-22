# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    # ticketを受け取り降車可能かboolを返すメソッド
    if ticket.fare >= calculate_fare(station_number, ticket.entered_gate.station_number)
      true
    else
      false
    end
  end
  
  private
  def calculate_fare(entered_station_num, exited_station_num)
    # 乗車駅番号、降車駅番号を受け取り運賃を返すメソッド
    # 降車駅 - 乗車駅の絶対値マイナス1がFARESに対応している
    diff = (exited_station_num - entered_station_num).abs
    idx = diff - 1
    FARES[idx]
  end
end
