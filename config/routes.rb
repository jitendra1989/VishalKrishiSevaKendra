Rails.application.routes.draw do

  require 'sidekiq/web'
  require 'admin_constraint'
  mount_roboto
  namespace :front, path: '' do
    match '404' => 'errors#not_found', via: :all
    match '500' => 'errors#internal_server_error', via: :all
    resource :customer, only: [:create, :edit, :update] do
      collection do
        match 'login' => 'customers#login', via: [:get, :post]
        delete 'logout'
        get 'activate/:token' => 'customers#activate', as: :activate
        match 'forgot-password' => 'customers#forgot_password', via: [:get, :post]
        match 'recover-password/:token' => 'customers#recover_password', via: [:get, :post], as: :recover_password
      end
      resources :orders, only: [:index]
    end
    resources :notifications, only: [:create]
    resources :categories, only: [:show]
    resources :offers, only: [:show]
    resources :products, only: [:show] do
      collection do
        get 'search'
      end
    end
    resource :cart, only: [:edit, :update] do
      collection do
        post 'add'
        post 'coupon-code' => 'carts#coupon_code'
        delete 'remove/:product_id' => 'carts#remove', as: :remove
      end
    end
    resource :order, only: [:create, :new] do
      collection do
        get 'payment'
        get 'success'
      end
    end

    root 'products#index'
    get 'pages/about'
    get 'pages/projects'
    get 'pages/clients'
    get 'pages/contact'
    resources :pages, only: [:show]
  end

  namespace :admin do
    mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new
    root 'users#dashboard'
    resources :reports, only: [] do
      collection do
        get 'stock'
        get 'workshop'
      end
    end
    resources :roles, except: [:show]
    resources :pages, except: [:show]
    resources :content_pages, path: 'content-pages', except: [:show]
    resources :coupon_codes, except: [:destroy, :show, :edit] do
      member do
        get 'edit(/:step)' => 'coupon_codes#edit', as: :edit
      end
    end
    resources :quotations, only: [:index] do
      collection do
        get 'products'
      end
    end
    resources :receipts, only: [:index, :show]
    resources :online_orders, path: 'online-orders', only: [:index, :show] do
      member do
        get 'invoice'
      end
    end
    get 'workshop/index'
    post 'workshop/assign'
    resources :order_item_customisations, only: [:index, :edit, :update]
    resources :order_item_image_customisations, only: [:index, :edit, :update]
    resources :orders, only: [:index, :create, :show, :edit], shallow: true do
      resources :receipts, except: [:edit, :update, :destroy]
      member do
        patch 'flag'
      end
    end
    resources :requirement_items, only: [:edit, :update]
    resources :requirements do
      collection do
        get 'products'
      end
    end
    resources :carts, except: [:new, :create, :show], shallow: true do
      collection do
        post 'add'
        post 'assign/:customer_id' => 'carts#assign', as: :assign
      end
      member do
        delete 'remove/:product_id' => 'carts#remove', as: :remove
      end
      resources :cart_items, only: [:edit, :update]
    end
    resources :customers, shallow: true do
      collection do
        get 'search'
      end
      resources :quotations, only: [:new, :create, :show]
      resources :invoices, only: [:new, :create, :show]
    end
    resources :invoices, only: [:index] do
      member do
        get 'gatepass'
        get 'dc'
      end
    end
    resources :product_types, path: 'product-types', only: [:index, :edit, :update]
    resources :taxes, except: [:show]
    resources :online_taxes, path: 'online-taxes', except: [:show], shallow: true do
         resources :online_taxes, only: [:new, :create]
       end
    resources :products, except: [:edit], shallow: true do
      member do
        get 'edit(/:step)' => 'products#edit', as: :edit
      end
      collection do
        get 'search'
      end
      resources :stocks, only: [:new, :create, :index]
    end
    resources :product_groups, path: 'product-groups', controller: :products, type: 'ProductGroup' do
      member do
        get 'add-stock' => 'products#add_stock', as: :add_stock
      end
    end

    resources :permissions, only: [:index]
    resources :outlets, except: [:show]
    resources :categories, except: [:show], shallow: true do
      resources :categories, only: [:new, :create]
      # member do
      #   get 'stock'
      # end
    end
    resources :banners, except: [:show]
    resources :specifications, except: [:show]
    resources :characteristics, except: [:show] do
      member do
        get 'images'
      end
    end
    resources :users do
      collection do
        match 'login' => 'users#login', via: [:get, :post]
        delete 'logout'
        match 'forgot-password' => 'users#forgot_password', via: [:get, :post]
        match 'recover-password/:token' => 'users#recover_password', via: [:get, :post], as: :recover_password
      end
    end
  end
end
