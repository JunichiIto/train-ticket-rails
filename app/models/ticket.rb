class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validate :can_exit_gate?

  def exited?
    !exited_gate_id.nil?
  end

  private
  def can_exit_gate?
    return if new_record? || !exited_gate_id_changed?

    before_gate_id = exited_gate_id_change[0]
    return errors.add(:base, 'This one had already exited') unless before_gate_id.nil?

    return errors.add(:exited_gate_id, 'Invalid exited_gate_id') if exited_gate.nil?

    errors.add(:exited_gate_id, 'では降車できません。') unless exited_gate.exit?(self)
  end
end
