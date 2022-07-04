FactoryBot.define do
  factory :order , aliases: [:owners_order] do
    user_id {1}
    title {'test order'}
    body {'test body'}
    association :user
  end
end
