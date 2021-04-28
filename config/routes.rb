Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  authenticate :user do
    resources :timelines,
      only: [:index, :show],
      param: :username
    resources :posts, only: [:create, :show]
end
end