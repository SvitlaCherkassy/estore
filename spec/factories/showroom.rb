FactoryGirl.define do
  factory :showroom do
    title { Faker::Company.name }
    association :user, :factory => :user
  end
end
