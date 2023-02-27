# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    exit_station_no = self.station_number
    enter_station_no = ticket.entered_gate.station_number
    diff = (enter_station_no - exit_station_no).abs
    case diff
    when 0 then
      return false
    when 1 then
      # 差が1だと150円以上
      return true if ticket.fare >= FARES[0]
      false
    else
      # 差が2だと190円以上
      return true if ticket.fare >= FARES[1]
      false
    end
  end
end
