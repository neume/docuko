Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#dashboard'
  get 'dashboard', to: 'pages#dashboard'

  # routes will start with /offices/<office.slug>/
  resources :offices, param: :slug do
    shallow_actions = %i[edit update show]

    resources :members, only: %i[index new create] do
      member do
        patch :change_role
      end
    end

    resources :search_users, only: [:index], defaults: { format: :json }

    resources :templates, only: shallow_actions

    resources :model_properties, only: shallow_actions

    resources :instances, only: shallow_actions do
      resources :documents
    end

    resources :instance_properties, only: shallow_actions
    resources :data_models do
      resources :model_properties, except: shallow_actions
      resources :instances, except: shallow_actions
      resources :templates, except: shallow_actions
    end
  end
end
