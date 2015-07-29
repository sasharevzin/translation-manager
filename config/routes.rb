Rails.application.routes.draw do
  resources :sources
  resources :translations, :only => 'destroy'  

  root to: 'sources#index'
end
