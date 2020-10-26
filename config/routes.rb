Rails.application.routes.draw do


  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    registrations: "admins/retistrations"
  }

  namespace :admin do
    get '/top', to: "admins#top", as: "top"
    post "/search", to: "admins#search", as: "search"
    get "/search", to: "admins#result"
    resources :items
    resources :categories, only: [:new, :edit, :update, :create]
    resources :customers, only: [:index, :show, :edit, :update]
    get "/orders/today", as: "orders_today"
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
  end

  scope module: :public do
    get "index/:id", to: "items#search", as: "search"
    resources :items, only: [:index, :show]
    delete "cart_items/destroy_all", to: "cart_items#destroy_all", as: "cart_items_all"
    resources :cart_items, only: [:index, :create, :update, :destroy]
    post "orders/log", to: "orders#log", as: "orders_log"
    get "orders/log", to: "orders#log"
    post "orders/check", to: "orders#check", as: "orders_check"
    get "orders/thanks", to: "orders#thanks", as: "orders_thanks"
    get "customers/quit", to: "customers#quit", as: "quit"
    patch "customers/out", to: "customers#out", as: "out"
    resources :orders, only: [:index, :show, :new, :create]
    resource :customers, only: [:show, :edit, :update]
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
  end

  devise_for :customers, controllers: {
    sessions: "customers/sessions",
    registrations: "customers/registrations"
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  

  scope module: :public do
    root "homes#top"
    get "/about", to: "homes#about", as: "about"
  end
end
