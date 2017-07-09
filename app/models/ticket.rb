class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true
  validates :entered_gate_id, presence: true

  def mark_as_used!(gate)
    update!(exited_gate: gate)
  end
end
