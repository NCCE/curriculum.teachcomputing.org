FactoryBot.define do
  factory :redirect do
    association :redirectable, factory: :lesson

    from { 'some-lesson' }
    to { 'a-different-lesson' }
  end
end
