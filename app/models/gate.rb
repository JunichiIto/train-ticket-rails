class Gate < ApplicationRecord
  FARES = [150, 190]

  validates :name, presence: true, uniqueness: true
  validates :number, presence: true, uniqueness: true

  scope :order_by_number, -> { order(:number) }

  def exit?(ticket)
    return false if ticket.entered_gate == self
    ticket.fare >= calc_fare(ticket)
  end

  private

  def calc_fare(ticket)
    from = ticket.entered_gate.number
    to = number
    distance = (to - from).abs
    FARES[distance - 1]
  end
end
