class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true

  validate :exited_gate_can_exit

  private

  def exited_gate_can_exit
    return unless exited_gate

    unless exited_gate.exit?(self)
      errors.add(:exited_gate, :can_not_exit)
    end
  end
end
