Rails.application.routes.draw do

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'singlepagetemplate'   => 'static_pages#singlepagetemplate'

  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :microposts
  #,          only: [:create, :destroy]




  #get 'itemsupdate' => 'carts#itemsupdate'
  #get 'compare' => 'static_pages#compare'

  get 'demoversion' => 'application#demoversion'

end
