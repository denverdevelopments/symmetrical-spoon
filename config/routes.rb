Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/competitions/:competition_id/new_team", to: 'competitions#new'
  post "/competitions/:competition_id", to: 'competitions#create'
  # post "/competitions/:competition_id/new_team", to: 'competitions#create'
  get "/competitions/:id", to: 'competitions#show'
  get "/competitions", to: 'competitions#index'
end
