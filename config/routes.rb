Rails.application.routes.draw do

  namespace :api do
    resources :users, only: [:create] do

      collection do
        post 'login'
      end

      resources :complaints, only: [:create], controller: "users/complaints" do
        resources :comments
        resources :likes
      end
    end

    resources :complaints, only: [:index]
  end
end
