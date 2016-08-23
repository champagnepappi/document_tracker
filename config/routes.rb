Rails.application.routes.draw do


  get 'documents/new'

  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'

  get 'contact' => 'static_pages#contact'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'
  resources :users
  resources :documents
  resources :messages
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

end
