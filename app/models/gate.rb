# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  STATION_SECTION = [
    [0, 1, 2],
    [1, 0, 1],
    [2, 1, 0]
  ].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    need_fare(ticket.entered_gate.station_number, station_number) <= ticket.fare
  end

  def need_fare(from_station_number, to_station_number)
    section = STATION_SECTION[from_station_number - 1][to_station_number - 1]
    raise '同じ駅で降りる場合の運賃はまだ未定義' if section.zero?

    FARES[section - 1]
  end
end
