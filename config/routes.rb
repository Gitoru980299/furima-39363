Rails.application.routes.draw do
  #get 'items/index'
  #get 'furimas/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 root to: 'items#index'
 resources :items
 devise_for :users
end
