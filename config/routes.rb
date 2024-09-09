Rails.application.routes.draw do
  namespace :v1 do
    post '/register', to: 'authentication#register'
    post '/login', to: 'authentication#login'

    resources :trucks, only: [:index] do
      member do
        post 'assign', to: 'trucks#assign_driver'
      end
      collection do
        get 'assigned', to: 'trucks#assigned_trucks'
      end
    end
  end
end
