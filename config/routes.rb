Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "hospitals#index"
  get "/home", to: redirect("/")


  draw :api
  draw :admin
  draw :doctors
  draw :patients

  resources :hospitals do
    member do
      get :doctors
    end
  end
  resources :profiles
  get "dashboard", to: "dashboard#show", defaults: { tab: "hospitals" }, as: :dashboard
  get "dashboard/:tab", to: "dashboard#show", as: :dashboard_tab, constraints: { tab: /hospitals|doctors|patients/ }
end
