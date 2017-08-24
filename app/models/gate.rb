# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  # 当駅で降りられる？＝運賃は足りている？
  def exit?(ticket)
    # 乗車駅と降車駅（当駅）の区間数
    traveled = (ticket.entered_gate.station_number - self.station_number).abs

    # 区間数から所要運賃を算出 ※traveledが範囲外であることは想定しない
    required_fare = FARES[traveled - 1]

    # 切符の額面が所要運賃以上？
    required_fare <= ticket.fare
  end
end
