class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validate :ensure_exitable_gate

  def used?
    !!exited_gate_id
  end

  private

  def ensure_exitable_gate
    return unless exited_gate_id
    unless exited_gate.exit?(self)
      errors.add(:exited_gate_id, :not_exitable_gate)
    end
  end
end
