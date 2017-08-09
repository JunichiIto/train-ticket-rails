class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validate :valid_exited_gate?

  private

  def valid_exited_gate?
    return if exited_gate.nil?
    unless exited_gate.exit?(self)
      errors.add(:exited_gate, ' では降車できません。')
    end
  end
end
