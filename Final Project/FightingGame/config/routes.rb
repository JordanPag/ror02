Rails.application.routes.draw do
  resources :heros, only: [:new, :create, :edit, :update, :destroy]
  get 'heros/:id', to: redirect('/')
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: "home#show"
  get 'battle', to: 'heros#battle'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
