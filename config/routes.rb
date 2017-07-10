Rails.application.routes.draw do
  root to: 'tickets#new'
  resources :tickets, only: %i(create edit update show)
end
