Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#dashboard'
  get 'dashboard', to: 'pages#dashboard'
  resources :offices, param: :slug do
    SHALLOW_ACTIONS= [:edit, :update, :show]

    member do
      get :admin
    end
    resources :templates, only: SHALLOW_ACTIONS
    resources :model_properties, only: SHALLOW_ACTIONS
    resources :instances, only: SHALLOW_ACTIONS
    resources :data_models do
      resources :model_properties, except: SHALLOW_ACTIONS
      resources :instances, except: SHALLOW_ACTIONS
      resources :templates, except: SHALLOW_ACTIONS
    end
  end
end
