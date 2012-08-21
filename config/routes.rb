Thrively::Application.routes.draw do
  root to: 'dashboard#index'

  resource :dashboard, only: :show
end
