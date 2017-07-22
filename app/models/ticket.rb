class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validate :must_not_exit_at_same_station, on: :update
  
  
  private
  def must_not_exit_at_same_station
    errors.add(:base, '降車駅 では降車できません。') unless exited_gate.exit?(self)
  end
end
