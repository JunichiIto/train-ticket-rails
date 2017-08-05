require 'test_helper'

class GateTest < ActiveSupport::TestCase
  setup do
    @umeda = gates(:umeda)
    @juso = gates(:juso)
    @mikuni = gates(:mikuni)
  end

  # 下り
  test 'うめだで150円の切符を買って、じゅうそうで降りる' do
    ticket = Ticket.create!(fare: 150, entered_gate: @umeda)
    assert @juso.exit?(ticket)
  end

  test 'うめだで190円の切符を買って、じゅうそうで降りる' do
    ticket = Ticket.create!(fare: 190, entered_gate: @umeda)
    assert @juso.exit?(ticket)
  end

  test 'うめだで150円の切符を買って、みくにで降りる（運賃不足）' do
    ticket = Ticket.create!(fare: 150, entered_gate: @umeda)
    refute @mikuni.exit?(ticket)
  end

  test 'うめだで190円の切符を買って、みくにで降りる' do
    ticket = Ticket.create!(fare: 190, entered_gate: @umeda)
    assert @mikuni.exit?(ticket)
  end

  test 'じゅうそうで150円の切符を買って、みくにで降りる' do
    ticket = Ticket.create!(fare: 150, entered_gate: @juso)
    assert @mikuni.exit?(ticket)
  end

  # 上り
  test 'みくにで150円の切符を買って、じゅうそうで降りる' do
    ticket = Ticket.create!(fare: 150, entered_gate: @mikuni)
    assert @juso.exit?(ticket)
  end

  test 'みくにで190円の切符を買って、じゅうそうで降りる' do
    ticket = Ticket.create!(fare: 190, entered_gate: @mikuni)
    assert @juso.exit?(ticket)
  end

  test 'みくにで150円の切符を買って、うめだで降りる（運賃不足）' do
    ticket = Ticket.create!(fare: 150, entered_gate: @mikuni)
    refute @umeda.exit?(ticket)
  end

  test 'みくにで190円の切符を買って、うめだで降りる' do
    ticket = Ticket.create!(fare: 190, entered_gate: @mikuni)
    assert @umeda.exit?(ticket)
  end

  test 'じゅうそうで150円の切符を買って、うめだで降りる' do
    ticket = Ticket.create!(fare: 150, entered_gate: @juso)
    assert @umeda.exit?(ticket)
  end

  # その他
  test '同じ駅では降りられない' do
    ticket = Ticket.create!(fare: 190, entered_gate: @umeda)
    refute @umeda.exit?(ticket)

    ticket = Ticket.create!(fare: 190, entered_gate: @juso)
    refute @juso.exit?(ticket)

    ticket = Ticket.create!(fare: 190, entered_gate: @mikuni)
    refute @mikuni.exit?(ticket)
  end
end
