Rails.application.routes.draw do

  devise_for :users

  namespace :api, :defaults => {:format => :json} do
    namespace :auth do
      post 'login' => 'authentication#login'
      # logout
    end

    get "/images", to: "images#index"
  end

end
