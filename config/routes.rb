Rails.application.routes.draw do
  get 'users/index'
  root 'static_pages#splash'

  devise_for :users
  resources :users do
    resources :categories, except: [:destroy]
    resources :deals
  end
end
