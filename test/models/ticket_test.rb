require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test 'relation' do
    ticket = Ticket.new(fare: 150)
    umeda = gates(:umeda)
    juso = gates(:juso)
    ticket.entered_gate = umeda
    ticket.exited_gate = juso
    ticket.save!

    ticket.reload
    assert_equal umeda, ticket.entered_gate
    assert_equal juso, ticket.exited_gate
  end

  test 'spent?' do
    umeda = gates(:umeda)
    juso  = gates(:juso)
    ticket = Ticket.new(fare: 150, entered_gate: umeda, exited_gate: juso)
    assert ticket.spent?
  end
end
