class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true

  validate :get_off_ticket?

  def get_off_ticket?
    errors.add(:get_off_ticket?, "降車駅 では降車できません。") if exited_gate.present? && !exited_gate.exit?(self)
  end
end
