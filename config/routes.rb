Rails.application.routes.draw do
  get '/dashboard', to: "dashboard#index", as: "dashboard"
  delete '/destroy_histories', to: "dashboard#destroy_histories", as: "dashboard_destroy_histories"
  get 'home/index'
  get "/search", to: "home#search", as: "home_search"
  root 'home#index'
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
