# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? || Rails.env.staging?
  4.times { |i|
    keyStage = KeyStage.find_or_create_by({description: "This is a KeyStage", ages: "#{i}-#{i+2}", years: "#{i}-#{i+2}", level: "#{i}"})
    keyStage.save!
    keyStage.published!
    yearGroup = keyStage.year_groups.find_or_create_by({year_number: "#{i}", description: "This is a YearGroup"})
    yearGroup.save!
    yearGroup.published!
    unit = yearGroup.units.find_or_create_by({title: "Unit #{i}", description: "This is a Unit"})
    unit.save!
    unit.published!
    lessons = unit.lessons.find_or_create_by({title: "Lesson #{i}", description: "This is a Lesson"})
    lessons.save!
    lessons.published!
    assessments = unit.assessments.find_or_create_by({title: "Lesson #{i}", description: "This is an Assessment"})
    assessments.save!
    assessments.published!
  }
end
