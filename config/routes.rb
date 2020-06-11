Rails.application.routes.draw do

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

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
