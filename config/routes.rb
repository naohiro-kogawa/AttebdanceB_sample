Rails.application.routes.draw do
  
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  put    'update'  => 'works#update' 
  post   '/works/:id/edit' , to: 'works#edit'
  resources :works
  # resources :worksがあるので修正はいらなかったですね。そのままコントローラーのアクションcreateの追加とビューの名前変更で行けると思います！
  resources :users do
   
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end