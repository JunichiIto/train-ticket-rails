require 'test_helper'

class GateTest < ActiveSupport::TestCase
  test 'fixture' do
    assert_equal 3, Gate.count
  end
end
