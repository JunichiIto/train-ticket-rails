class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true

  validate :gate_exit_should_be_successful, if: -> { exited_gate.present? }
  def gate_exit_should_be_successful
    unless exited_gate.exit?(self)
      errors.add(:exited_gate, 'では降車できません。')
    end
  end

  def exited?
    exited_gate.present?
  end
end
