Rails.application.routes.draw do
  devise_for :users 
  root to: 'prototypes#index'

  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    #表示は投稿画面で表示させる
    resources :comments, only: :create 
  end
  #User情報の詳細のみを表示させるので
  resources :users, only: :show
end
