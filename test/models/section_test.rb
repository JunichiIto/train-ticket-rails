require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  setup do
    @umeda  = gates(:umeda)
    @juso   = gates(:juso)
    @mikuni = gates(:mikuni)
  end

  test 'うめだ => じゅうそう の区間料金' do
    section = Section.new(boarding: @umeda, alighting: @juso)
    assert section.fare == 150
  end

  test 'うめだ => みくに の区間料金' do
    section = Section.new(boarding: @umeda, alighting: @mikuni)
    assert section.fare == 190
  end

  test 'じゅうそう => みくに の区間料金' do
    section = Section.new(boarding: @juso, alighting: @mikuni)
    assert section.fare == 150
  end

  test 'みくに => じゅうそう の区間料金' do
    section = Section.new(boarding: @mikuni, alighting: @juso)
    assert section.fare == 150
  end

  test 'みくに => うめだ の区間料金' do
    section = Section.new(boarding: @mikuni, alighting: @umeda)
    assert section.fare == 190
  end

  test 'same_stations?' do
    section = Section.new(boarding: @umeda, alighting: @umeda)
    assert section.same_stations?
  end
end
