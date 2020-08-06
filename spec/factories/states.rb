FactoryBot.define do
  factory :state do
    association :stateable, factory: :unit
    state { State.states[:unpublished] }

    factory :published_state do
      state { State.states[:published] }
    end
  end
end
