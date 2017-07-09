require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test 'relation' do
    ticket = Ticket.new(fare: 150)
    umeda = gates(:umeda)
    ticket.entered_gate = umeda
    ticket.save!

    assert_equal umeda, ticket.reload.entered_gate
  end
end
