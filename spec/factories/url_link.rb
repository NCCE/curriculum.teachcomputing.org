FactoryBot.define do
  factory :url_link do
    unit
    label { "Digital Summative Assessment" }
    url { "https://www.google.com" }
    type_descriptor { "Google Docs" }
  end
end
