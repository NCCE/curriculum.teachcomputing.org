Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'

  post '/graphql', to: 'graphql#execute'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: redirect('/admin')

  namespace :admin do
    resources :key_stages, only: %i[show edit index] do
      post '/publish', to: 'key_stages#publish'
      post '/unpublish', to: 'key_stages#unpublish'
      delete :teacher_guide, action: :destroy_teacher_guide
    end
    resources :year_groups, only: %i[show index] do
      post '/publish', to: 'year_groups#publish'
      post '/unpublish', to: 'year_groups#unpublish'
    end
    resources :units do
      post '/publish', to: 'units#publish'
      post '/unpublish', to: 'units#unpublish'
      delete :unit_guide, action: :destroy_unit_guide
      delete :learning_graphs, action: :destroy_learning_graph
      delete :rubrics, action: :destroy_rubric
      delete :summative_assessments, action: :destroy_summative_assessment
      delete :summative_answers, action: :destroy_summative_answer
    end
    resources :lessons do
      post '/publish', to: 'lessons#publish'
      post '/unpublish', to: 'lessons#unpublish'
      delete :zipped_contents, action: :destroy_zipped_contents
    end
    root to: 'units#index'
  end

  direct :cdn_proxy do |model, options|
    if model.respond_to?(:signed_id)
      route_for(
        :rails_service_blob_proxy,
        model.signed_id,
        model.filename,
        options.merge(host: 'd2wwad22u0qj8o.cloudfront.net')
      )
    else
      signed_blob_id = model.blob.signed_id
      variation_key  = model.variation.key
      filename       = model.blob.filename

      route_for(
        :rails_blob_representation_proxy,
        signed_blob_id,
        variation_key,
        filename,
        options.merge(host: 'd2wwad22u0qj8o.cloudfront.net')
      )
    end
  end
end
