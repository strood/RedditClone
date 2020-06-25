Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :show, :create, :update]

  resources :subs, except: [:destroy]

  resources :posts, except: [:index]

  resource :session, only: [:new, :create, :destroy]
end
