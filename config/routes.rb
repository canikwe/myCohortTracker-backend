Rails.application.routes.draw do
  # resources :cohort_activities
  resources :activities, only: [:index, :create]
  resources :groups, except: [:new, :edit, :show]
  resources :students, only: [:index]
  resources :cohorts, only: [:index, :show, :create]
  post '/cohorts/csv_upload', to: 'cohorts#csv_upload'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
