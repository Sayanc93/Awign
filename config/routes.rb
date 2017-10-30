Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api, module: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :interns
      devise_for :project_managers

      resources :workforces
      resources :companies

      resources :interns do
        collection do
          get :tasks
          get :project
        end
      end

      resources :projects do
        member do
          post :assign_manager
        end
      end

      resources :tasks do
        member do
          post :assign_intern
          post :change_status
        end
      end

      resources :project_managers do
        collection do
          post :add_intern
          put :remove_intern_from_task
          delete :remove_intern_from_workforce
        end
      end
    end
  end
end
