require 'test_helper'

class GateTest < ActiveSupport::TestCase
  setup do
    @umeda = gates(:umeda)
    @juso = gates(:juso)
    @mikuni = gates(:mikuni)
  end

  test 'うめだで乗って、じゅうそうで降りる' do
    ticket = Ticket.create!(fare: 150, entered_gate: @umeda)
    assert @juso.exit(ticket)
  end
end
