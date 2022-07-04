FactoryBot.define do
  factory :suggestion do
    user_id {1}
    order_id {1}
    title {'test order'}
    body {'test body'}
    association :user
    order  {user.owners_order}
  end
end
