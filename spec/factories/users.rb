FactoryBot.define do
  factory :user do
    email { 'web@raspberrypi.org' }
    password { 'nJ4uDaaFyc3nHzsy' }
    password_confirmation { password }
  end
end
