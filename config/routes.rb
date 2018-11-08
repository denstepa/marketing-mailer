Rails.application.routes.draw do

  namespace :admin do
    resources :campaigns do
      member do
        post :send_test
        post :schedule
      end
    end

    # mount Sidekiq::Web => '/sidekiq'

    root to: 'campaigns#index'
  end

end
