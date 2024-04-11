Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: redirect("/admin")

  namespace :admin do
    resources :key_stages, only: %i[show edit index update] do
      post "/publish", to: "key_stages#publish"
      post "/unpublish", to: "key_stages#unpublish"
      delete :teacher_guide, action: :destroy_teacher_guide
      delete :journey_progress_pdf, action: :destroy_journey_progress_pdf
      delete :journey_progress_icon, action: :destroy_journey_progress_icon
    end
    resources :year_groups, only: %i[show index] do
      post "/publish", to: "year_groups#publish"
      post "/unpublish", to: "year_groups#unpublish"
    end
    resources :units, only: %i[create new show edit index update] do
      post "/publish", to: "units#publish"
      post "/unpublish", to: "units#unpublish"
      delete :unit_guide, action: :destroy_unit_guide
      delete :learning_graphs, action: :destroy_learning_graph
      delete :rubrics, action: :destroy_rubric
      delete :summative_assessments, action: :destroy_summative_assessment
      delete :summative_answers, action: :destroy_summative_answer
    end
    resources :lessons, only: %i[create new show edit index update] do
      post "/publish", to: "lessons#publish"
      post "/unpublish", to: "lessons#unpublish"
      delete :zipped_contents, action: :destroy_zipped_contents
    end
    resources :curriculum_maps, except: :index
    resources :taxonomy_tags
    resources :learning_objectives, only: %i[index show edit update]
    resources :redirects, only: %i[show update]
    resources :success_criteria, only: %i[show]
    resources :national_curriculum_statements
    resources :connected_world_strands
    root to: "units#index"
  end
end
