Rails.application.routes.draw do

  resources :posts do
    resources :comments
  end
  devise_for :users
  resources :users
  get 'welcome/index'
  get 'welcome', to: 'welcome#index'
  root 'posts#index'
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
