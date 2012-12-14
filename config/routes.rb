Thrively::Application.routes.draw do
  # users

  constraints Clearance::Constraints::SignedIn.new do
    root to: 'dashboards#show'
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'high_voltage/pages#show', id: 'marketing'
  end


  resources :invites, only: [:new, :create]
  resource :accept, only: :show
  resources :users, only: [:new, :create, :show, :edit, :update]
  resource :session, only: [:create]

  # dashboard

  resource :dashboard, only: :show

  # core workflow

  resources :requests, only: [:new, :create]
  resources :requested_feedbacks, only: :show
  resources :feedbacks, only: [:new, :create]

  # aliases

  match '/about', to: 'high_voltage/pages#show', id: 'about', as: :about
  match '/give', to: 'feedbacks#new', as: :new_feedback
  match '/jobs', to: 'high_voltage/pages#show', id: 'jobs', as: :jobs
  match '/privacy', to: 'high_voltage/pages#show', id: 'privacy', as: :privacy
  match '/request', to: 'requests#new', as: :new_request
  match '/sign_up', to: 'high_voltage/pages#show', id: 'marketing', as: :sign_up
  match '/terms', to: 'high_voltage/pages#show', id: 'terms', as: :terms
  match '/thanks', to: 'high_voltage/pages#show', id: 'thanks', as: :thanks
  match '/welcome', to: 'high_voltage/pages#show', id: 'welcome', as: :welcome

  # admin

  resource :admin, only: [:show]

  namespace :admin do
  end

  if Rails.env.development?
    mount Mailer::Preview => 'mail_view'
  end
end
