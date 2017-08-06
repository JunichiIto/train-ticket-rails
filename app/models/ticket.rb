class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validate :can_exit?, on: :update

  RIDE_SECTION_FARES = {1 => 150, 2 => 190}
  private_constant :RIDE_SECTION_FARES

  def can_exit?
    @errors.add(:exited_gate_id,"では降車できません。") unless exited_gate.exit?(self)
  end

  def pay_enough?(ride_section)
    return false if ride_section == 0
    fare >= RIDE_SECTION_FARES[ride_section]
  end
end
