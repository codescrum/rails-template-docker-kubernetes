FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email("#{Faker::Name.first_name}.#{Faker::Name.last_name}") }
    password {'123456789'}
    password_confirmation {'123456789'}
  end
end
