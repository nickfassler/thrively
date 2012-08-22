Thrively::Application.routes.draw do
  root to: 'dashboards#show'

  resource :dashboard, only: :show
  resources :requests, only: [:new, :create]
end
