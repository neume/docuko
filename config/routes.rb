Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#dashboard'
  get 'dashboard', to: 'pages#dashboard'

  # routes will start with /offices/<office.slug>/
  resources :offices, param: :slug do
    shallow_actions = %i[edit update show]

    member do
      get :destroy_modal
    end

    resources :members, only: %i[index new create] do
      member do
        patch :change_role
      end
    end

    resources :search_users, only: [:index], defaults: { format: :json }

    resources :templates, only: shallow_actions.push(:destroy) do
      member do
        get :destroy_modal
      end
    end

    resources :model_properties, only: shallow_actions.push(:destroy) do
      member do
        get :destroy_modal
      end
    end

    resources :documents, only: [:destroy] do
      member do
        get :destroy_modal
      end
    end

    resources :instances, only: shallow_actions.push(:destroy) do
      resources :documents

      member do
        get :destroy_modal
      end
    end

    resources :instance_properties, only: shallow_actions
    resources :data_models do
      member do
        get :destroy_modal
      end
      resources :model_properties, except: shallow_actions
      resources :instances, except: shallow_actions
      resources :templates, except: shallow_actions
    end
  end
end
