Rails.application.routes.draw do
  get 'posts/create'
  get 'posts/new'
  get 'posts/edit'
  get 'posts/show'
  get 'posts/update'
  get 'posts/destroy'
  # resources :users
  # root 'forums#index'
  # get '/users', to: 'users#index', as: 'users'
  # get '/users/new', to: 'users#new', as: 'new_user'
  # get '/users/:id', to: 'users#show', as: 'user'
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  # post '/users', to: 'users#create'
  # post '/users/:id/logon', to: 'users#logon', as: 'user_logon'
  # delete '/users/logoff', to: 'users#logoff', as: 'user_logoff'
  # patch '/users/:id', to: 'users#update'
  # # delete '/users/:id', to: 'users#delete'
  # resources :forums
  resources :forums do
    resources :posts, shallow: true, except: [:index]
    resources :subscriptions, shallow: true, except: [:index]
  end
  get '/subscriptions', to: 'subscriptions#index', as: 'subscriptions'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
