concern :searchable do
  collection do
    get :search
  end
end

resources :doctors, concerns: :searchable do
  resources :appointments, only: [ :index ]
end
