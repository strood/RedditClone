Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :show, :create]

  resources :subs

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

  root to: redirect('/session/new')
end
