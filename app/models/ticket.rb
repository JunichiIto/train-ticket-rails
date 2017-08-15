class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validates :exited_gate_id, presence: true, on: :update
  validate :exit?, on: :update

  def exit?
    errors.add(:exited_gate_id, "では降車できません。") unless exited_gate.exit? self
  end

  def exited?
    exited_gate_id != nil
  end
end
