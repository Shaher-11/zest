Rails.application.routes.draw do
  get 'posts/create'
  devise_for :users
  root to: 'home#index'
  authenticate :user do
    resources :timelines,
      only: [:index, :show],
      param: :username
end
end