Rails.application.routes.draw do
  # mount_devise_token_auth_for 'User', at: 'auth'

  devise_for :users

  post 'login' => 'authentication#login'
  # logout

  namespace :api, :defaults => {:format => :json} do
    get "/images", to: "images#index"
  end

end
