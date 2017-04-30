Rails.application.routes.draw do
  # mount_devise_token_auth_for 'User', at: 'auth'

  devise_for :users

  post 'login' => 'authentication#login'
  # logout

  namespace :api, :defaults => {:format => :json} do
    get  "/todos",  to: "todos#index"
    post "/todos",  to: "todos#create"

    get  "/todos/done",  to: "todos#index_done"
    get  "/todos/open",  to: "todos#index_open"

    put    "/todos/:id",  to: "todos#update"
    delete "/todos/:id",  to: "todos#destroy"
  end

end
