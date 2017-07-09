class Gate < ApplicationRecord
  FARES = [150, 190]

  validates :name, presence: true, uniqueness: true
  validates :number, presence: true, uniqueness: true

  def exit(ticket)
    ticket.fare >= calc_fare(ticket)
  end

  private

  def calc_fare(ticket)
    from = ticket.entered_gate.number
    to = number
    distance = to - from
    FARES[distance - 1]
  end
end
