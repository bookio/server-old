Booker::Application.routes.draw do

  #get "sessions/new"

 # get "users/new"

  #resource :rental
  
  match "/rentals" => "rentals#index", :via => :get, :defaults => { :format => 'json' }
  match "/rentals" => "rentals#create", :via => :post, :defaults => { :format => 'json' }
  match "/rentals/:id" => "rentals#show", :via => :get, :defaults => { :format => 'json' }, :as => :rental
  match "/rentals/:id" => "rentals#destroy", :via => :delete, :defaults => { :format => 'json' }
  match "/rentals/:id" => "rentals#update", :via => :put, :defaults => { :format => 'json' }

  match "/customers" => "customers#index", :via => :get, :defaults => { :format => 'json' }
  match "/customers" => "customers#create", :via => :post, :defaults => { :format => 'json' }
  match "/customers/:id" => "customers#show", :via => :get, :defaults => { :format => 'json' }, :as => :customer
  match "/customers/:id" => "customers#destroy", :via => :delete, :defaults => { :format => 'json' }
  match "/customers/search/:search_text" => "customers#search", :via => :get, :defaults => { :format => 'json' }

  match "/users" => "users#index", :via => :get, :defaults => { :format => 'json' }
  match "/users" => "users#create", :via => :post, :defaults => { :format => 'json' }
  match "/users/:id" => "users#show", :via => :get, :defaults => { :format => 'json' }, :as => :user
  match "/users/:id" => "users#destroy", :via => :delete, :defaults => { :format => 'json' }

  match "/sessions" => "sessions#create", :via => :post, :defaults => { :format => 'json' }
  match "/sessions/:id" => "sessions#destroy", :via => :delete, :defaults => { :format => 'json' }
  match "/sessions" => "sessions#index", :via => :get, :defaults => { :format => 'json' }
  match "/sessions/:id" => "sessions#show", :via => :get, :defaults => { :format => 'json' }, :as => :session
  
  match "/login" => "sessions#login", :via => :get, :defaults => { :format => 'json' }
  match "/logout" => "sessions#logout", :via => :get, :defaults => { :format => 'json' }

  match "/reservations" => "reservations#index", :via => :get, :defaults => { :format => 'json' }
  match "/reservations" => "reservations#create", :via => :post, :defaults => { :format => 'json' }
  match "/reservations/:id" => "reservations#show", :via => :get, :defaults => { :format => 'json' }, :as => :reservation
  match "/reservations/:id" => "reservations#destroy", :via => :delete, :defaults => { :format => 'json' }

  #resources :users, :has_many => :reservations
  #resources :rentals, :has_many => :reservations
  #resources :customers, :has_many => :reservations
  
  root :to => "home#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
