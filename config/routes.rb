Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :likes, only: [:create]
      resources :comments, only: [:new, :create, :destroy]
    end
  end
  root "users#index"
  # delete '/users/:user_id/posts/:id' to: 'posts#destroy', as post_delete
  # delete '/users/:user_id/post/:id', to: 'posts#destroy', as: :post_delete
  # delete '/delete/comment/:id', to: 'comments#destroy', as: :comment_delete
  # delete '/users/:user_id/delete/:id', to: 'posts#destroy'
  # get '/gossip/:id', to: 'gossip#show', as: :gossip
end
