Rails.application.routes.draw do
  resources :sources
  resources :translations, only: 'destroy'

  get 'search', to: 'sources#search'

  root to: 'sources#index'
end
