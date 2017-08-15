# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    gate_interval = fetch_gate_interval(ticket.entered_gate_id)

    # 運賃不足ではないかチェック
    if gate_interval.zero?
      false
    elsif FARES[gate_interval - 1] <= ticket.fare
      true
    else
      false
    end
  end

  private

  def fetch_gate_interval(entered_gate_id)
    (
      entered_station_number(entered_gate_id) - station_number
    ).abs
  end

  def entered_station_number(gate_id)
    Gate.find(gate_id).station_number
  end
end
