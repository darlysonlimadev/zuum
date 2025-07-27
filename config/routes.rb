Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "corridas#index"

  resources :usuarios
  resources :corridas do
    collection do
      get :filtrar_usuario
    end
  end

end
