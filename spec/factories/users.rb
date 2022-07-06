FactoryBot.define do
  factory :user, aliases: [:owner]  do
    id {1}
    name { "Aaron" }
    email { "tester@example.com" }
    password { "dottle-nouveau-pavilion-tights-furze" }
    password_confirmation { "dottle-nouveau-pavilion-tights-furze" }
  end
end