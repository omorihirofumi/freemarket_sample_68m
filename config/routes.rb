Rails.application.routes.draw do

  get 'purchase/index'
  get 'purchase/done'
  root 'items#index'
  resources :items
    resources :comments

  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :card, only: [:new, :show, :destroy] do
    collection do
      post 'show', to: 'card#showing'
      post 'pay', to: 'card#pay'
    end
  end

  #住所登録をウィザード形式で表示させる
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  get "mypages/index"
  get "mypages/logout"

end