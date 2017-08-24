class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validate :exited_gate_id_validation


  # カスタムvalidation: exited_gate_idの駅で降りられるか？
  def exited_gate_id_validation
    return if exited_gate_id.to_i == 0

    unless exited_gate.exit?(self)
      errors.add(:exited_gate, "では降車できません。")
    end
  end
end
