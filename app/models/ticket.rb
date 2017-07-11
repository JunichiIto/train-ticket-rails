class Ticket < ApplicationRecord
  with_options class_name: 'Gate' do
    belongs_to :entered_gate, foreign_key: 'entered_gate_id'
    belongs_to :exited_gate,  foreign_key: 'exited_gate_id', optional: true
  end

  with_options presence: true do
    validates :fare, inclusion: Gate::FARES
    validates :entered_gate_id
  end

  with_options on: :exit do
    validates :exited_gate_id, presence: true
    validate :ensure_gates_are_not_same
    validate :ensure_section_fare_can_be_paid
  end

  def spent?
    exited_gate.present?
  end

  private

  def section
    @_section ||= Section.new(boarding: entered_gate, alighting: exited_gate)
  end

  def ensure_gates_are_not_same
    errors.add(:exited_gate, :invalid) if section.same_stations?
  end

  def ensure_section_fare_can_be_paid
    errors.add(:fare, :invalid) if fare < section.fare
  end
end
