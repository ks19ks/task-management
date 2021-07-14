FactoryBot.define do
  factory :user do
    name { "admin" }
    email { "admin@example.com" }
    admin { true }
    password { "password" }
  end
  factory :user2, class: User do
    name { "general" }
    email { "general@example.com" }
    admin { false }
    password { "password" }
  end
end
