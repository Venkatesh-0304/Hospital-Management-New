concern :searchable do
  collection do
    get :search
  end
end

resources :patients, concerns: :searchable do
  collection do
    get :export
  end
  resources :appointments, only: [ :index, :new, :create ]
end

resources :appointments do
  member do
    patch :cancel
  end
  collection do
    get :upcoming
  end
end
