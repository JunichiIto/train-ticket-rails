class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true

  validate :can_get_off?, if: -> { exited_gate.present? }, on: :update

  def used?
    exited_gate.present?
  end

  def can_get_off?
    unless exited_gate.exit?(self)
      errors[:exited_gate] << 'では降車できません。'
    end
  end
end
