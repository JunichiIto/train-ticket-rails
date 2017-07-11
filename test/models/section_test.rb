require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  setup do
    @umeda  = gates(:umeda)
    @juso   = gates(:juso)
    @mikuni = gates(:mikuni)
  end

  test 'うめだ => じゅうそう の区間料金' do
    ticket  = Ticket.create!(fare: 150, entered_gate: @umeda, exited_gate: @juso)
    section = Section.new(ticket)
    assert section.fare == 150
  end

  test 'うめだ => みくに の区間料金' do
    ticket  = Ticket.create!(fare: 190, entered_gate: @umeda, exited_gate: @mikuni)
    section = Section.new(ticket)
    assert section.fare == 190
  end

  test 'じゅうそう => みくに の区間料金' do
    ticket  = Ticket.create!(fare: 150, entered_gate: @juso, exited_gate: @mikuni)
    section = Section.new(ticket)
    assert section.fare == 150
  end

  test 'みくに => じゅうそう の区間料金' do
    ticket  = Ticket.create!(fare: 150, entered_gate: @mikuni, exited_gate: @juso)
    section = Section.new(ticket)
    assert section.fare == 150
  end

  test 'みくに => うめだ の区間料金' do
    ticket  = Ticket.create!(fare: 190, entered_gate: @mikuni, exited_gate: @umeda)
    section = Section.new(ticket)
    assert section.fare == 190
  end

  test 'same_stations?' do
    ticket  = Ticket.create!(fare: 150, entered_gate: @umeda, exited_gate: @umeda)
    section = Section.new(ticket)
    assert section.same_stations?
  end
end
