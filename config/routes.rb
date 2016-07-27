Rails.application.routes.draw do

  root "users#loginpage"
  post "/login" => "users#login"


  get "/registration_page" => "users#registration_page"
  post "/register" => "users#register"


  get "/dashboard" => "users#dashboard"

  post '/submitfishes' => "users#submitfishes"

  get '/entries' => "users#summary"

  get '/fish_date_count/:date' => "users#fish_date_count"

end
