FactoryGirl.define do
  factory :user do
    email_address { Faker::Internet.email }
    name { Faker::Name.name }
    password 'PAD SOURCE'
    password_confirmation 'PAD SOURCE'
  end
end
