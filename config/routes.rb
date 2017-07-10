Rails.application.routes.draw do
  root to: 'tickets#new'
  resources :tickets, only: %i(index create show edit update)
end
