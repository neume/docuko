Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#dashboard'
  get 'dashboard', to: 'pages#dashboard'
  resources :offices, param: :slug do
    SHALLOW_ACTIONS = %i[edit update show].freeze

    member do
      get :admin
    end

    resources :members, only: %i[index new create] do
      member do
        patch :change_role
      end
    end

    resources :templates, only: SHALLOW_ACTIONS

    resources :model_properties, only: SHALLOW_ACTIONS

    resources :instances, only: SHALLOW_ACTIONS do
      resources :documents
    end

    resources :instance_properties, only: SHALLOW_ACTIONS
    resources :data_models do
      resources :model_properties, except: SHALLOW_ACTIONS
      resources :instances, except: SHALLOW_ACTIONS
      resources :templates, except: SHALLOW_ACTIONS
    end
  end
end
