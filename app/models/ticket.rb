class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validate :must_be_able_to_exit, if: ->() { exited_gate }

  def used?
    !!exited_gate_id
  end

  private

  def must_be_able_to_exit
    unless exited_gate.exit?(self)
      # TODO: 今後の多言語化を考えて、 message は config/locales/以下のファイルから参照したい。
      errors.add(:exited_gate, :cannot_exit, message: 'では降車できません。')
    end
  end
end
