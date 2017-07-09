require "application_system_test_case"

class TicketsTest < ApplicationSystemTestCase
  test '乗車して降車する' do
    visit root_path
    select '150円', from: '運賃'
    select 'うめだ', from: '乗車駅'
    click_button '乗る'
    assert_text '乗りました。'

    select 'みくに', from: '降車駅'
    click_button '降りる'
    assert_text 'では降車できません。'

    select 'じゅうそう', from: '降車駅'
    click_button '降りる'
    assert_text '降りました。'
  end
end