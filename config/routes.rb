Booker::Application.routes.draw do

  
  get "/rentals" => "rentals#index", :defaults => { :format => 'json' }
  post "/rentals" => "rentals#create", :via => :post, :defaults => { :format => 'json' }
  get "/rentals/query" => "rentals#query", :defaults => { :format => 'json' }
  get "/rentals/:id" => "rentals#show", :defaults => { :format => 'json' }, :as => :rental
  delete "/rentals/:id" => "rentals#destroy", :defaults => { :format => 'json' }
  put "/rentals/:id" => "rentals#update", :defaults => { :format => 'json' }

  get "/scenes" => "scenes#index", :defaults => { :format => 'json' }
  post "/scenes" => "scenes#create", :via => :post, :defaults => { :format => 'json' }
  get "/scenes/:id" => "scenes#show", :defaults => { :format => 'json' }, :as => :scene
  delete "/scenes/:id" => "scenes#destroy", :defaults => { :format => 'json' }
  put "/scenes/:id" => "scenes#update", :defaults => { :format => 'json' }

  get "/categories" => "categories#fetch_all", :defaults => { :format => 'json' }
  post "/categories" => "categories#create", :via => :post, :defaults => { :format => 'json' }
  get "/categories/:id" => "categories#fetch", :defaults => { :format => 'json' }, :as => :category
  delete "/categories/:id" => "categories#destroy", :defaults => { :format => 'json' }
  put "/categories/:id" => "categories#update", :defaults => { :format => 'json' }

  get "/customers" => "customers#index", :defaults => { :format => 'json' }
  post "/customers" => "customers#create", :via => :post, :defaults => { :format => 'json' }
  get "/customers/search_email" => "customers#search_email", :defaults => { :format => 'json' }
  get "/customers/search/:search_text" => "customers#search", :defaults => { :format => 'json' }
  get "/customers/:id" => "customers#show", :defaults => { :format => 'json' }, :as => :customer
  delete "/customers/:id" => "customers#destroy", :defaults => { :format => 'json' }
  put "/customers/:id" => "customers#update", :defaults => { :format => 'json' }

  get "/users" => "users#index", :defaults => { :format => 'json' }
  post "/users" => "users#create", :via => :post, :defaults => { :format => 'json' }
  get "/users/guest" => "users#guest", :defaults => { :format => 'json' }
  get "/users/:id" => "users#show", :defaults => { :format => 'json' }, :as => :user
  delete "/users/:id" => "users#destroy", :defaults => { :format => 'json' }
  put "/users/:id" => "users#update", :defaults => { :format => 'json' }

  resources :icons, defaults: { format: :json } do
    collection do
      get 'all'
      get 'folder/:folder' => 'icons#get_by_folder'
    end
  end

  get "/clients/:id" => "clients#show", :defaults => { :format => 'json' }, :as => :client
  get "/client" => "clients#self_get", :defaults => { :format => 'json' }
  put "/client" => "clients#self_update", :defaults => { :format => 'json' }

  get "/clients" => "clients#index", :defaults => { :format => 'json' }
  post "/clients" => "clients#create", :defaults => { :format => 'json' }

  delete "/clients/:id" => "clients#destroy", :defaults => { :format => 'json' }
  put "/clients/:id" => "clients#update", :defaults => { :format => 'json' }

  delete "/sessions/:id" => "sessions#destroy", :defaults => { :format => 'json' }
  get "/sessions" => "sessions#index", :defaults => { :format => 'json' }
  get "/sessions/:id" => "sessions#show", :defaults => { :format => 'json' }, :as => :session
  
  get "/signup" => "sessions#signup", :defaults => { :format => 'json' }
  get "/login" => "sessions#login", :defaults => { :format => 'json' }
  get "/logout" => "sessions#logout", :defaults => { :format => 'json' }
  get "/verify" => "sessions#verify", :defaults => { :format => 'json' }

  get "/reservations" => "reservations#index", :defaults => { :format => 'json' }
  post "/reservations" => "reservations#create", :via => :post, :defaults => { :format => 'json' }
  get "/reservations/foo" => "reservations#foo", :defaults => { :format => 'json' }
  get "/reservations/:id" => "reservations#show", :defaults => { :format => 'json' }, :as => :reservation
  delete "/reservations/:id" => "reservations#destroy", :defaults => { :format => 'json' }
  put "/reservations/:id" => "reservations#update", :defaults => { :format => 'json' }

  get "/settings" => "settings#index", :defaults => { :format => 'json' }
  put "/settings/:section/:name" => "settings#put", :defaults => { :format => 'json' }
  get "/settings/:section/:name" => "settings#get", :defaults => { :format => 'json' }
  delete "/settings/:section/:name" => "settings#destroy", :defaults => { :format => 'json' }
  delete "/settings/:section" => "settings#destroy_section", :defaults => { :format => 'json' }

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
