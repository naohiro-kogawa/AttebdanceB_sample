Rails.application.routes.draw do
  
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post   'update'  => 'works#update' #出勤ボタンが反応した際のルートが調べると　update_path	POST	/update(.:format)	works#update　ルートの書き方が問題なのか、ボタン側の書き方が悪いのかわかりません。
  resources :works
  resources :users do
   
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end