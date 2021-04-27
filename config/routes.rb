Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  authenticate :user do
    resources :timelines,
      only: [:index, :show]
  end
end
