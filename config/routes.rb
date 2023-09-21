Rails.application.routes.draw do
  get 'deals/index'
  get 'deals/show'
  get 'categories/index'
  get 'categories/show'
  get 'users/index'
  root 'static_pages#splash'

  devise_for :users
  resources :users do
    resources :categories, except: [:destroy]
    resources :deals
  end
end
