Rails.application.routes.draw do
  resources :mons
  get 'visitors/index'
  root to: 'mons#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
