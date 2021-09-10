FactoryBot.define do
  factory :learning_objective do
    description { 'MyString' }
    order { 1 }
    lesson { nil }

    factory :primary_learning_objective do
      success_criteria { [build(:success_criterion)] }

      before(:create) do |learning_objective|
        success_criteria { [build(:success_criterion, learning_objective: learning_objective)] }
      end
    end
  end
end
