FactoryBot.define do
  factory :video do
    title { "MyVideo" }
    name { "John Smith" }
    job_title { "Head Teacher" }
    description { "This is the video description" }
    video_url { "https://www.youtube.com/watch?v=6VsXL8g4yNs" }
  end
end
