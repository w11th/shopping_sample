Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions, only: %i[new create destroy]
  delete '/logout' => 'sessions#destroy', as: :logout

  resources :categories, only: %i[show]
  resources :products, only: %i[show]
  resources :shopping_carts
  resources :addresses do
    put 'set_default_address', on: :member
  end
  resources :orders

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products do
      resources :product_images, only: %i[index create destroy update]
    end
  end
end
