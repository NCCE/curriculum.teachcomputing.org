# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def add_year_group(key_stage, year_number, i)
  year_group = key_stage.year_groups.create({ year_number: year_number.to_s })
  year_group.published!

  unit = year_group.units.create({ title: "Unit #{year_number}", description: 'This is a Unit' })
  unit.published!

  download_record = AggregateDownload.create(
    count: i,
    downloadable: unit,
    attachment_type: 'zipped_contents'
  )

  i.times do
    download_record.downloads.create
    unit.add_positive_rating
    unit.add_negative_rating
  end

  lesson = unit.lessons.create(
    {
      title: "A lesson (Year #{year_number})",
      description: 'This is a Lesson'
    }
  )

  if lesson.primary?
    learning_objective = LearningObjective.new(
      {
        description: 'I am an objective',
        order: 1,
        lesson: lesson
      }
    )

    learning_objective.success_criteria = [
      SuccessCriterion.new(
        {
          description: 'I am a success',
          order: 1,
          learning_objective: learning_objective
        }
      ),
      SuccessCriterion.new(
        {
          description: 'I am also a success',
          order: 2,
          learning_objective: learning_objective
        }
      )
    ]

    learning_objective.save!
  else
    lesson.learning_objectives.create(
      [
        {
          description: 'I am mr objectivator',
          order: 1
        },
        {
          description: 'I object to mr objectivator',
          order: 2
        }
      ]
    )
  end

  lesson.published!

  download_record = AggregateDownload.create(
    count: i,
    downloadable: lesson,
    attachment_type: 'zipped_contents'
  )

  i.times do
    download_record.downloads.create
    lesson.add_positive_rating
    lesson.add_negative_rating
  end
end

if Rails.env.development? || Rails.env.staging?
  puts 'Clearing existing records'
  Rating.delete_all
  AggregateRating.delete_all

  Download.delete_all
  AggregateDownload.delete_all

  State.delete_all

  SuccessCriterion.delete_all
  LearningObjective.delete_all

  Lesson.delete_all
  Unit.delete_all
  YearGroup.delete_all
  KeyStage.delete_all

  4.times do |j|
    i = j + 1
    puts '*' * 50
    puts "Creating KeyStage #{i}"
    key_stage = KeyStage.create(
      {
        description: 'This is a KeyStage',
        ages: "#{i}-#{i + 2}",
        years: "#{i}-#{i + 2}",
        level: i.to_s
      }
    )
    key_stage.published!

    download_record = AggregateDownload.create(
      count: i,
      downloadable: key_stage,
      attachment_type: 'zipped_contents'
    )
    i.times do
      download_record.downloads.create
    end

    puts 'Adding YearGroup'
    case i
    when 1
      (1..2).each do |yn|
        add_year_group(key_stage, yn, i)
      end
    when 2
      (3..6).each do |yn|
        add_year_group(key_stage, yn, i)
      end
    when 3
      (7..9).each do |yn|
        add_year_group(key_stage, yn, i)
      end
    when 4
      %w[Non-GCSE GCSE].each do |yn|
        add_year_group(key_stage, yn, i)
      end
    end
  end
end
