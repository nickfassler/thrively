Thrively::Application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'dashboards#show'
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'high_voltage/pages#show', id: 'marketing'
  end

  resource :accept, only: :show
  resource :dashboard, only: :show
  resources :feedbacks, only: [:new, :create]
  resources :invites, only: [:new, :create]
  resources :requests, only: [:new, :create]
  resources :requested_feedbacks, only: :show
  resource :session, only: [:create]
  resources :users, only: [:new, :create, :show, :edit, :update]

  match '/about', to: 'high_voltage/pages#show', id: 'about', as: :about
  match '/give', to: 'feedbacks#new', as: :new_feedback
  match '/jobs', to: 'high_voltage/pages#show', id: 'jobs', as: :jobs
  match '/privacy', to: 'high_voltage/pages#show', id: 'privacy', as: :privacy
  match '/request', to: 'requests#new', as: :new_request
  match '/sign_up', to: 'high_voltage/pages#show', id: 'marketing', as: :sign_up
  match '/thanks', to: 'high_voltage/pages#show', id: 'thanks', as: :thanks

  if Rails.env.development?
    mount Mailer::Preview => 'mail_view'
  end
end
