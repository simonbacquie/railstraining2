Rails.application.routes.draw do
  devise_for :users
  # root to: 'pages#ember'

  mount_ember_app :frontend, to: "/"

  post 'auth_user' => 'authentication#authenticate_user'

  namespace :api, :defaults => {:format => :json} do
    get "/images", to: "images#index"
  end
end
