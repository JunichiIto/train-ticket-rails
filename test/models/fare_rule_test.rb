class FareRuleTest < ActiveSupport::TestCase
  setup do
    @umeda = gates(:umeda)
    @juso = gates(:juso)
    @mikuni = gates(:mikuni)
  end

  test 'find_by_gates when inbound' do
    fare_rule = FareRule.find_by_gates(@umeda, @juso)
    assert_equal fare_rule.number_of_section, 1
  end

  test 'find_by_gates when outbound' do
    fare_rule = FareRule.find_by_gates(@mikuni, @umeda)
    assert_equal fare_rule.number_of_section, 2
  end

  test 'find_by_gates when missing' do
    missing_gate = Gate.new(name: 'missing', station_number: 100)
    fare_rule = FareRule.find_by_gates(@mikuni, missing_gate)
    assert_nil fare_rule
  end
end
