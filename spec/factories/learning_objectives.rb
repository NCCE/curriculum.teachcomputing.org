FactoryBot.define do
  factory :learning_objective do
    description { "MyString" }

    factory :primary_learning_objective do
      success_criteria { [build(:success_criterion)] }
    end
  end
end
