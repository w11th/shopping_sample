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

  namespace :dashboard do
    scope 'profile' do
      controller :profile do
        get :password
        put :update_password
      end
    end

    resources :orders, only: [:index]
    resources :addresses, only: [:index]
  end

  resources :orders
  resources :payments, only: [:index] do
    collection do
      get 'generate_pay'
      get 'pay_return'
      get 'pay_notify'
      get 'success'
      get 'failed'
    end
  end

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products do
      resources :product_images, only: %i[index create destroy update]
    end
  end
end
