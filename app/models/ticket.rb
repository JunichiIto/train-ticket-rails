class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true
  validates :entered_gate_id, presence: true

  validate :exited_gate_can_exit, :fare_in_money_of_fare_rule

  def used?
    exited_gate.present?
  end

  private

  def exited_gate_can_exit
    return unless exited_gate

    unless exited_gate.exit?(self)
      errors.add(:exited_gate, :can_not_exit)
    end
  end

  def fare_in_money_of_fare_rule
    unless FareRule.pluck(:money).include?(fare)
      errors.add(:fare, :inclusion)
    end
  end
end
