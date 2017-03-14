Rails.application.routes.draw do
  resources :events
  resources :marriage_branches
  resources :descendant_branches
  resources :memories
  resources :photos
  resources :relatives
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
