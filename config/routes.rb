Rails.application.routes.draw do


# 顧客用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do
    root to: "homes#top"
    get 'users/check'
    patch 'users/withdraw', to: 'users#withdraw'
    resources :users, only: [:show, :edit, :update, :index] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'searches/search'
    resources :paintings, only: [:show, :edit, :update,:create,:new, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :painting_comments, only: [:create, :destroy]
    end
    get 'homes/top'
    get 'homes/about'
    get "search" => "searches#search"
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    get '/' => "homes#top"
    resources :users, only: [:show, :edit, :update, :index] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'users/check'
    patch 'users/withdraw', to: 'users#withdraw'
    get 'searches/search'
    resources :paintings, only: [:show, :edit, :update,:create, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :painting_comments, only: [:create, :destroy]
    end
    get 'homes/top'
    get 'homes/about'
    get "search" => "searches#search"
    get 'homes/top'
    get 'homes/about'
  end
end
