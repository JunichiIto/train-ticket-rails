class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true
  validates :entered_gate_id, presence: true
  validate :validate_exited_gate, if: -> { exited_gate.present? }
  def validate_exited_gate
    unless exited_gate.exit?(self)
      errors.add(:exited_gate, 'では降車できません。')
    end
  end

  scope :not_exited, -> { where(exited_gate_id: nil) }

  def exited?
    exited_gate.present?
  end
end
