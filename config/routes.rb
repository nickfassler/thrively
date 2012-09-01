Thrively::Application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'dashboards#show'
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'high_voltage/pages#show', :id => 'marketing'
  end

  resource :dashboard, only: :show
  resources :requests, only: [:new, :create]
  resources :feedbacks, only: [:new, :create]
  resources :requested_feedbacks, only: :show

  match '/request' => 'requests#new'
  match '/give' => 'feedbacks#new', as: :give_feedback
  match '/:user_id' => 'feedbacks#new', as: :profile,
    constraints: { user_id: /\d+/ }
end
