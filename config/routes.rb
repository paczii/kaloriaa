Rails.application.routes.draw do
  resources :compares
  resources :directions
  resources :routes
  resources :optimizations
  resources :carts
  resources :stocks
  resources :options
  resources :drivers
  resources :products
  resources :orders
  resources :stores
  resources :vehicles
  resources :distances
  resources :customers
  mount Ckeditor::Engine => '/ckeditor'
  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'shop'   => 'static_pages#shop'

  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :microposts
  #,          only: [:create, :destroy]


  get    'startmodell'   => 'application#startmodell'


  get 'itemsupdate' => 'carts#itemsupdate'
  get 'productslist' => 'products#productslist'
  get 'additemtocart' => 'products#additemtocart'
  get 'additemtofavs' => 'products#additemtofavs'
  get 'deleteitem' => 'carts#deleteitem'
  get 'updatestocks' => 'stocks#updatestocks'
  get 'resetstocks' => 'stocks#resetstocks'
  get 'updatedistances' => 'distances#updatedistances'

  get 'createorder' => 'orders#create'
  get 'settimewindow' => 'orders#settimewindow'
  get 'setcustomer' => 'orders#setcustomer'

  get 'startbinpackingg' => 'orders#startbinpackingg'


  # Für Optimierungen

  get 'capacitytest' => 'optimizations#capacitytest'
  get 'gamstest' => 'options#gamstest'

  get 'realopt' => 'optimizations#realopt'
  get 'pickuponlyhome' => 'optimizations#pickuponlyhome'
  get 'pickuponlystation' => 'optimizations#pickuponlystation'
  get 'homedeliverystore' => 'optimizations#homedeliverystore'
  get 'homedeliverywarehouse' => 'optimizations#homedeliverywarehouse'

  # Führt zur Erstellung eines Fahrers bei Erstellung eines Fahrer-Accounts
  get 'newdriver' => 'drivers#create'


  get 'compare' => 'static_pages#compare'
  get 'testaddresse' => 'static_pages#testaddresse'
  get 'testaddressefunction' => 'distances#testaddressefunction'

  get 'generator' => 'static_pages#generator'
  get 'generateorder' => 'orders#generateorder'

  get 'demoversion' => 'application#demoversion'

end
