Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  #auth
  get "auth/:provider/callback", to: "sessions#google_auth"
  get "auth/failure", to: redirect("/")
  get 'login', to: "sessions#new", as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout

  resources :projects, only: [:index, :show]
  resources :time_sheets, only: [:create, :index]
  resources :approve_time_sheets, only: [:update, :index]
  resources :adjust_time_sheets, only: [:new, :create, :index]
  resources :cancel_time_sheets, only: [:update]
  resources :users, only: [:show]
  resources :total_hours, only: [:index]
  
  get 'user-time-sheet/:project_id', to: "time_sheets#show"
  put 'user/projects/:project_id/:command', to: "user_projects#update"
  get 'user/:id/profile', to: "user_profiles#show"

  get 'sync-projects', to: "sync_projects#index"
  post 'sync-projects', to: "sync_projects#create"

  namespace :reports do
    resources :allocations, only: [:new, :create]
  end  

  namespace :api do
    
      resources "time_sheets", only: [:index], format: :json do
        collection do
          get "by_user_email_in_period/:email/:start_date/:end_date", action: :by_user_email_in_period, constraints: {:email => /[\w.]+/ }
          get "by_user_email_in_date/:email/:year/:month", action: :by_user_email_in_date, constraints: {:email => /[\w.]+/ }
          get "by_project_gfp/:project_id/:start_date/:end_date", action: :by_project_gfp
          get "all_by_project_gfp/:project_id", action: :all_by_project_gfp
          get "register_time_sheet/:user_email/:gfp_project_id/:hours_spent/:year/:month", action: :register_time_sheet,
           constraints: {:user_email => /[\w.@]+/ }
        end
      end
    

    namespace :v2 do
      get 'hours-worked/:project_id', to: "hours_workeds#index"
    end
  end
  
end
