Rails.application.routes.draw do

  namespace :admin do
    get 'admins/top', to: "admins#top", as: "top"
    resources :items
  end

  scope module: :public do
    resources :items, only: [:index, :show]
    delete "cart_items/destroy_all", to: "cart_items#destroy_all", as: "cart_items_all"
    resources :cart_items, only: [:index, :create, :update, :destroy]
    post "orders/log", to: "orders#log", as: "orders_log"
    post "orders/check", to: "orders#check", as: "orders_check"
    get "orders/thanks", to: "orders#thanks", as: "orders_thanks"
    get "customers/quit", to: "customers#quit", as: "customers_quit"
    post "customers/out", to: "customers#out", as: "customers_out"
    resources :orders, only: [:index, :show, :new, :create]
    resource :customers, only: [:show, :edit, :update]
    resources :deliveries, only: [:index, :create, :edit, :update]
  end
  devise_for :customers, controllers: {
    sessions: "customers/sessions",
    registrations: "customers/registrations"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    registrations: "admins/retistrations"
  }
  

  scope module: :public do
    root "homes#top"
    get "/about", to: "homes#about", as: "about"
  end
end
