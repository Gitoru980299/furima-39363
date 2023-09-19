Rails.application.routes.draw do
  devise_for :users
  
 root to: "items#index"
 resources :items, only: [:new] do
  #resources :comments, only: :create
 end
end
#, :create, :show, :edit, :update, :destroy