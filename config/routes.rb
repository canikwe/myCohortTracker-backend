Rails.application.routes.draw do
  resources :users, only: [:create]
  # resources :cohort_activities
  resources :activities, only: [:index, :create]
  resources :groups, except: [:new, :edit, :show]
  resources :students, except: [:new, :show, :edit]
  resources :cohorts, except: [:new, :edit, :destroy]
  post '/cohorts/csv_upload', to: 'cohorts#csv_upload'
  post '/login', to: 'auth#create'
  post '/token_login', to: 'auth#token_login'
  post '/google_login', to: 'auth#google_login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
