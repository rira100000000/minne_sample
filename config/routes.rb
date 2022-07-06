Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'portfolio/home'
  get 'users/index'
  root 'portfolio#home'
  get  '/signup',  to: 'users#new'
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :orders
  resources :suggestions
  resources :comments ,only: [:create, :destroy]
  get  'my_orders',  to: 'orders#my_orders'

end
