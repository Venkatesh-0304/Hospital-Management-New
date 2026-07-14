Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "hospitals#index"
  get "/home", to: redirect("/")


  draw :api
  draw :admin
  draw :doctors
  draw :patients

  resources :hospitals
  resources :profiles
end
