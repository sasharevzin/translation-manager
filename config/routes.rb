Rails.application.routes.draw do
  resources :sources
  root to: 'sources#index'
end
