namespace :admin do
  resources :hospitals, only: [ :index ]
  resources :users, only: [ :index, :destroy ]
end
