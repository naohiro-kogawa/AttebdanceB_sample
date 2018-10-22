Rails.application.routes.draw do
  
  get 'practice/index'
  post 'practice/index'
get  '/test',  to: 'practice#index'
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'hoges'    => 'static_pages#test'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'static_pages/test'
  post 'static_pages/test'
  resources :users do
    resources :apples
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  #resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  #like機能拡張用に指定
  resources :microposts do
    resources :likes, only: [:create, :destroy]
  end
end