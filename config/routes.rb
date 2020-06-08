Rails.application.routes.draw do
  namespace 'admin' do
    resources :key_stages do
      resources :year_groups do
        resources :unit do
          resources :lessons
          resources :assessment
        end
      end
    end
  end
end
