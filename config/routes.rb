Rails.application.routes.draw do

  root 'products#index'
  get 'pages/about'
  get 'pages/projects'
  get 'pages/clients'
  get 'pages/contact'
  resources :products, only: [:show]

  namespace :admin do
    root 'users#dashboard'
    resources :roles, except: [:show]
    resources :quotations, only: [:index] do
      collection do
        get 'products'
      end
    end
    resources :carts, except: [:new, :create, :show] do
      collection do
        post 'add'
      end
      member do
        delete 'remove/:product_id' => 'carts#remove', as: :remove
      end
    end
    resources :customers, shallow: true do
      resources :quotations, only: [:new, :create, :show]
    end
    resources :product_types, path: 'product-types', only: [:index, :edit, :update]
    resources :taxes, except: [:show]
    resources :products, shallow: true do
      resources :stocks, only: [:new, :create, :index]
    end
    resources :permissions, only: [:index]
    resources :outlets, except: [:show]
    resources :categories, except: [:show], shallow: true do
      resources :categories, only: [:new, :create]
    end
    resources :users do
      collection do
        match 'login' => 'users#login', via: [:get, :post]
        delete 'logout'
      end
    end
  end

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
