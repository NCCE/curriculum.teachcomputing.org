Datadog.configure do |c|
  c.use :rails, service_name: "curriculum_teachcomputing_#{Rails.env}" unless ENV['RAILS_ENV'] == 'development'
end
