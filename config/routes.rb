Rails.application.routes.draw do
  root to: 'public/homes#top'


  devise_for :customers,skip: [:passwords],  controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }

  root to: "public/homes#top"
  namespace :public do
    resources :customers, only: [:new, :create]
    resources :items, only: [:index, :show]
    resources :customers, only: [:new, :create]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :cart_items, only: [:create, :index, :update, :destroy] do
      delete :destroy_all, on: :collection
    end
  end

  get "admin" => "admin/homes#top"
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
  end
  scope module: :public do
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


