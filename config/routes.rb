Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'sessions/new'
  get 'pages/index'
  get 'profile', to: 'users#show'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  post 'login', to: 'sessions#create'
  get 'signup', to: 'users#new'
  

  resources :articles do
    resources :comments
  end

  resources :categories
  resources :deliveries

  post '/deliveries/search' => 'deliveries#search', :as => "deliveries/search"
  
  post '/deliveries/delete_category' => 'deliveries#delete_category', :as => "deliveries/delete_category"

  post '/deliveries/update_status' => 'deliveries#update_status', :as => "deliveries/update_status"
  
  post '/deliveries/calculate_ems' => 'deliveries#calculate_ems', :as => "deliveries/calculate_ems"
  post '/deliveries/update' => 'deliveries#update', :as => "deliveries/update"
  
  root 'deliveries#index'
  
  # root 'welcome#index'

  # post "/api", to: "api#calculate_ems"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"



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
