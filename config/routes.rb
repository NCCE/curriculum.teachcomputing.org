Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'

  post '/graphql', to: 'graphql#execute'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'admin/application_controller#authenticate_admin'
  #root to: 'admin/key_stages#index'

  namespace :admin do
    resources :units do
      post '/publish', to: 'units#publish'
      post '/unpublish', to: 'units#unpublish'
    end
    resources :year_groups do
      post '/publish', to: 'year_groups#publish'
      post '/unpublish', to: 'year_groups#unpublish'
    end
    resources :lessons do
      post '/publish', to: 'lessons#publish'
      post '/unpublish', to: 'lessons#unpublish'
    end
    resources :key_stages do
      post '/publish', to: 'key_stages#publish'
      post '/unpublish', to: 'key_stages#unpublish'
    end
    resources :assessments do
      post '/publish', to: 'assessments#publish'
      post '/unpublish', to: 'assessments#unpublish'
    end
    root to: 'units#index'
  end
end
