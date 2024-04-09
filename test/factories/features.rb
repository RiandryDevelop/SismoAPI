FactoryBot.define do
  factory :feature do
    id { Faker::Number.unique.number(digits: 10) }
    type { 'feature' }
    attributes do
      {
        external_id: nil,  # Intentional error: setting external_id to nil
        magnitude: Faker::Number.decimal(l_digits: 2),
        place: Faker::Address.city,
        time: Faker::Time.backward(days: 365).iso8601,
        tsunami: Faker::Boolean.boolean,
        mag_type: Faker::Lorem.word,
        title: Faker::Lorem.sentence,
        coordinates: {
          longitude: Faker::Address.longitude,
          latitude: Faker::Address.latitude
        }
      }
    end
    links do
      {
        external_url: Faker::Internet.url
      }
    end
  end
end
