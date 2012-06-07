FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { "#{rand}-#{rand}-aTads" }
    password_confirmation { |u| u.password }
  end

  factory :admin_user do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { "#{rand}-#{rand}-aTads" }
    password_confirmation { |u| u.password }
  end
end

