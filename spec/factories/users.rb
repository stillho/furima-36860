FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { 'a1b2c3d4' }
    password_confirmation { password }
    last_name            { '山田' }
    read_name_last       { 'ヤマダ' }
    first_name            { '太郎' }
    read_name_first       { 'タロウ' }
    birthday { '2000-01-01' }
  end
end
