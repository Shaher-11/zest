Rails.application.routes.draw do
  get 'timelines/index'
  get 'timelines/show'
  devise_for :users
  root to: 'home#index'
  
end
