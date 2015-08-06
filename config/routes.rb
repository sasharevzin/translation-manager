Rails.application.routes.draw do
  match 'sources/update_by_text_and_lang' => 'sources#update_by_text_and_lang', via: [:put, :patch]
  resources :sources
  resources :translations, only: 'destroy'

  get 'search', to: 'sources#search'

  root to: 'sources#index'
end
