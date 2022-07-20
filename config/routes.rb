Rails.application.routes.draw do
  get 'confirms/create'
  get 'confirms/show'
  get 'confirms/destroy'
  get 'sessions/new'
  get 'users/new'
  get '/new', to: 'orders#new'
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
  resources :comments ,only: [:create]
  resources :messages ,only: [:create]
  get  'my_orders',  to: 'orders#my_orders'
  get 'tags/show'
  post 'orders/upload_image'
  resources :confirms ,only: [:create, :destroy,:show,:update]

  resources :confirms do
  #特定のデータを対象とする場合(つまり「:id」をURLにつける。）
    member do
      get :detail
    end
  end  
  
end
