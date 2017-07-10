require "application_system_test_case"

class TicketsTest < ApplicationSystemTestCase
  test '乗車して降車する' do
    visit root_path
    select '150円', from: '切符'
    select 'うめだ', from: '乗車駅'
    click_button '乗車する'
    assert_text '乗車しました。'

    select 'じゅうそう', from: '降車駅'
    click_button '降車する'
    assert_text '降車しました。'
  end

  test '運賃が足りない場合' do
    visit root_path
    select '150円', from: '切符'
    select 'うめだ', from: '乗車駅'
    click_button '乗車する'
    assert_text '乗車しました。'

    select 'みくに', from: '降車駅'
    click_button '降車する'
    assert_text 'では降車できません。'
  end

  test 'すでに使用済みの切符を指定されたらトップページに移動する' do
    ticket = Ticket.create!(fare: 150, entered_gate: gates(:umeda), exited_gate: gates(:juso))
    visit edit_ticket_path(ticket)
    assert_current_path root_path
    assert_text '降車済みの切符です。'
  end

  test 'indexにアクセスされたらrootに移動する' do
    visit tickets_path
    assert_current_path root_path
  end

  test 'showにアクセスされたらeditに移動する' do
    ticket = Ticket.create!(fare: 150, entered_gate: gates(:umeda))
    visit ticket_path(ticket)
    assert_current_path edit_ticket_path(ticket)
  end
end