require 'sidekiq/web'

Sidekiq::Web.set :session_secret, Rails.configuration.secret_token

Rails.application.routes.draw do

  namespace :admin do
    resources :campaigns do
      member do
        post :send_test
        post :schedule
      end
    end

    mount Sidekiq::Web => '/sidekiq'

  end

  root to: 'admin/campaigns#index'

end
