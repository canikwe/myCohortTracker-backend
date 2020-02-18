Rails.application.routes.draw do
  resources :activities
  resources :student_groups
  resources :groups
  resources :pairs, only: [:index, :create]
  resources :students, only: [:index]
  resources :cohorts, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
