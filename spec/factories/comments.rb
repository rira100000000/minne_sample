FactoryBot.define do
  factory :comment do
    user_id {1}
    suggestion_id {1}
    content {'test comment'}
    association :user
    association :suggestion
  end
end
