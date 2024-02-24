Rails.application.routes.draw do


  devise_for :customers,skip: [:passwords],  controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }

  root to: "public/homes#top"
  namespace :public do
    get"home/about" => "homes#about", as: "about"
    get '/genre/search' => 'searches#genre_search'
    resources :customers, only: [:new, :create]
    resources :items, only: [:index, :show]
    resources :customers, only: [:new, :create]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show] do
      post :confirm, on: :collection
      get :thanks, on: :collection
    end
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'
    resources :cart_items, only: [:create, :index, :update, :destroy] do
      delete :destroy_all, on: :collection
    end
  end


  get "admin" => "admin/homes#top"
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end
  scope module: :public do
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

