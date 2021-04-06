require "faker"

FactoryBot.define do
  factory :user do
    firstname { "MMM" }
    sequence(:lastname) { |n| "_#{n}" }
    sequence(:email) { |n| "test_#{n}@covidliste.com" }
    password { "securepassword" }

    confirmed_at { Time.zone.now }
    address { Faker::Address.city }
    phone_number { Faker::PhoneNumber.phone_number }
    birthdate { DateTime.now - 30.years }
    toc { true }
  end
end
