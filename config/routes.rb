Thrively::Application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'dashboards#show'
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'high_voltage/pages#show', :id => 'marketing'
  end

  resource :accept, only: :show
  resource :dashboard, only: :show
  resources :feedbacks, only: [:new, :create]
  resources :invites, only: [:new, :create]
  resources :requests, only: [:new, :create]
  resources :requested_feedbacks, only: :show
  resources :users, only: [:new, :create, :show, :edit, :update]

  match '/request' => 'requests#new'
  match '/give' => 'feedbacks#new', as: :give_feedback
end
