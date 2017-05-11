Rails.application.routes.draw do
  root to: 'home#index'
  resources :event_tags
  resources :photo_tags
  resources :events
  resources :marriage_branches
  resources :descendant_branches
  resources :memories
  resources :photos
  resources :relatives
  get '/home', to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
