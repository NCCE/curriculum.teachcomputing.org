Rails.application.routes.draw do
  root to: 'admin/key_stages#index'

  namespace :admin do
    resources :units
    resources :year_groups
    resources :lessons
    resources :key_stages
    resources :assessments
    root to: 'units#index'
  end
end
