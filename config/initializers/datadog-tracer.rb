Datadog.configure do |c|
  c.use :rails, service_name: "curriculum_teachcomputing_#{Rails.env}" unless ENV['ENV_TYPE'] == "development"
end
