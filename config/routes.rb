Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions

  delete '/logout' => 'sessions#destroy', as: :logout

  namespace :admin do
    root 'categories#index'
    resources :sessions
    resources :categories
    resources :products
  end
end
