FactoryGirl.define do
  factory :complaint do
    title { Faker::App.name }
    description { Faker::Lorem.paragraph }
    category 'Pothole'
    longitude '100.100'
    latitude '100.100'
  end
end
