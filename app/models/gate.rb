class Gate < ApplicationRecord
  FARES = [150, 190]

  validates :name, presence: true, uniqueness: true
  validates :number, presence: true, uniqueness: true

  def exit(ticket)
    true
  end
end
