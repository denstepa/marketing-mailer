Rails.application.routes.draw do

  namespace :admin do
    resources :campaigns

    # mount Sidekiq::Web => '/sidekiq'

    root to: 'campaigns#index'
  end

end
