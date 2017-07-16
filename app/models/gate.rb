# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    fare(ticket.entered_gate) == ticket.fare # FIXME: 支払った金額が多い場合のことが考慮されていない
  end

  private

  def fare(other)
    # FIXME: 同じ駅のときの料金を強制的にnilにしている。現状のFARESの構造にベッタリと依存している
    ([nil] + FARES)[distance(other)]
  end

  def distance(other)
    (station_number - other.station_number).abs
  end
end
