Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    member do
     get :followeruser, :followeduser
    # get :search, on: :collection
    end
    
    # collection do
    # get :search
    # end
  end
  
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  post 'search/result' => 'search#search', as: 'search'
  
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  
  resources :relationships, only: [:create, :destroy]
  
  # devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about', as: 'about'
end