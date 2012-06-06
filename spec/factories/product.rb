FactoryGirl.define do
  factory :product do
    name { Faker::Company.name }
    description "test product"
    price 1_000
    image { File.new(Rails.root.join("spec", "support", "files", "chromium_logos.jpg")) }
    publish_at Date.today - 1.month
  end
end
