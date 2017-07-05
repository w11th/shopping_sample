Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :categories, only: %i[show]
  resources :products, only: %i[show]

  delete '/logout' => 'sessions#destroy', as: :logout

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products do
      resources :product_images, only: %i[index create destroy update]
    end
  end
end
