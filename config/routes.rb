SnookerApp::Application.routes.draw do
  get "clubs/new"
  get "players/new"
  resources :users
  resources :profiles
  resources :sessions, only: [:new, :create, :destroy]
  resources :players
  resources :clubs
  resources :tournaments
  resources :password_resets
  resources :enters, only: [:create, :destroy]
  root  'players#index'
  match '/breaks',   to: 'static_pages#high_break',  via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/admin/users', to: 'admin#users',       via: 'get'
  match '/admin/players', to: 'admin#players',  via: 'get'
  match '/admin/clubs',   to: 'admin#clubs',    via: 'get'
  match '/admin/tournaments', to: 'admin#tournaments', via: 'get'
  get '/tournaments/:id/finish' => 'tournaments#finish', :as => :tournament_finish
  match 'tournaments/:id/finish', to: 'tournaments#done', via: ['put', 'patch', 'post']
  get "/admin/approve/:id" => "admin#approve_user", :as => :approve_user
  get "/admin/deactivate/:id" => "admin#deactivate_user", :as => :deactivate_user
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
