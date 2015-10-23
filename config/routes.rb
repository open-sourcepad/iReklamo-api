Rails.application.routes.draw do

  namespace :api do
    resources :users, only: [:create] do

      collection do
        post 'login'
      end

      resources :complaints, only: [:create], controller: "users/complaints" do
        resources :comments, controller: "comments"
      end
    end
  end
end
