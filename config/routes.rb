Rails.application.routes.draw do
  resources :sources

  match "sources/update_by_text_and_lang" => "sources#update_by_text_and_lang", via: [:put, :patch]

  root to: 'sources#index'
end
