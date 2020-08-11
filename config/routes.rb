Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Static pages
  get "pages/:page" => "pages#show"

  resources :users, only: [:new, :show, :create] do
    member do
      get :subscriptions, to: "users#subscriptions", as: "subscriptions"
    end
  end

  resources :subs do
    member do
      post :subscribe, to: "subs#subscribe", as: "subscribe"
      post :unsubscribe, to: "subs#unsubscribe", as: "unsubscribe"
    end
  end

  resources :posts, except: [:index] do
    member do
      post :upvote, to: "posts#upvote", as: "upvote"
      post :downvote, to: "posts#downvote", as: "downvote"
    end
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create, :show, :new]do
    member do
      post :upvote, to: "comments#upvote", as: "upvote"
      post :downvote, to: "comments#downvote", as: "downvote"
    end
  end

  resource :session, only: [:new, :create, :destroy]

  root to: redirect('/pages/about')
end
