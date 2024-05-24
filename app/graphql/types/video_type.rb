module Types
  class VideoType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :name, String, null: true
    field :job_title, String, null: true
    field :description, String, null: true
    field :video_url, String, null: false
  end
end
