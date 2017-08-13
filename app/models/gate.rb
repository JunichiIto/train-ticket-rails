# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord

  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  # 指定されたチケットで改札から出られるか
  # @params [Ticket] ticket 購入したチケット
  # @return [Boolean] true:出られる
  def exit?(ticket)
    return false if ticket.nil?
    return false if self == ticket.entered_gate
    calc_fare(ticket) <= ticket.fare
  end

  # 他ゲートとの比較
  # NOTE: クラスのチェックする？
  #
  # @params [Gate] other 比較対象のゲート
  # @return [Boolean] 駅番号が一致する場合にtrue
  def ==(other)
    return false if other.nil?
    self.station_number == other.station_number
  end

  private

    # チケットから運賃を計算する
    # @params [Ticket] ticket 乗車チケット
    # @return [Integer] 運賃
    def calc_fare(ticket)
      FARES[distance_from(ticket.entered_gate) - 1]
    end

    # 指定された改札がある駅との区間距離を取得する
    # @params [Gate] gate 改札機
    # @return [Integer] 改札との区間
    def distance_from(gate)
      (station_number - gate.station_number).abs
    end

end
