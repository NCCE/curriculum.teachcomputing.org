# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? || Rails.env.staging?
  4.times { |i|
    keyStage = KeyStage.create({description: "This is a KeyStage", ages: "#{i}-#{i+2}", level: "#{i}"})
    yearGroup = keyStage.year_groups.create({year_number: "#{i}", description: "This is a YearGroup"})
    unit = yearGroup.units.create({title: "Unit #{i}", description: "This is a Unit"})
    unit.lessons.create({title: "Lesson #{i}", description: "This is a Lesson"})
    unit.assessments.create({title: "Lesson #{i}", description: "This is an Assessment"})
  }
end
