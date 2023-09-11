FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name            {'徹'}
    first_name_kana       {'トオル'}
    last_name             {'松本'}
    last_name_kana        {'マツモト'}
    birthday              {'1930-01-01'}
  end
end