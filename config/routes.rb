# frozen_string_literal: true

Rails.application.routes.draw do
  # post request - localhost:3000/books
  
  require 'sidekiq/web'

  scope :monitoring do
    # Sidekiq Basic Auth from routes on production environment
    if Rails.env.production?
      Sidekiq::Web.use Rack::Auth::Basic do |username, password|
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username),
                                                    ::Digest::SHA256.hexdigest(Rails.application.credentials.sidekiq[:auth_username])) &
          ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password),
                                                      ::Digest::SHA256.hexdigest(Rails.application.credentials.sidekiq[:auth_password]))
      end
    end
    mount Sidekiq::Web, at: '/sidekiq'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :users do
        post :login
        delete :logout
        get :me
        post :create
      end
      # post request - localhost:3000/api/v1/books/books
      resources :books, only: [:create, :destroy, :update]

      # localhost:3000/api/v1/books/my_books
      namespace :books do 
        get :my_books
        # post :create 
        # localhost:3000/api/v1/books/delete
        # delete :delete
      end
    end
  end
end
