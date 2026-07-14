namespace :api do
  namespace :v1 do
    resources :patients, only: [] do
      resources :appointments, shallow: true do
        member do
          patch :cancel
        end
        collection do
          get :upcoming
        end
      end
    end
  end
end
