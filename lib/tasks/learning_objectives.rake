namespace :learning_objectives do
  desc "Takes objectives from lessons and converts them to lesson objective
  database entries"
  task populate: :environment do
    SuccessCriterion.destroy_all
    LearningObjective.destroy_all

    lessons = Lesson.all

    lessons.each do |lesson|
      if lesson.primary?
        add_primary_lesson_objectives(lesson)
      else
        add_secondary_lesson_objectives(lesson)

      end
    end
  end

  desc "Adds taxonomy tags to learning objectives"
  task add_tags: :environment do
    require "csv"
    failed_count = 0
    # failed = []
    data_hash = JSON.parse(File.read("TCC.json"))
    data_hash.each do |entry|
      desc = entry["objective"].gsub("\n", ", ").downcase
      learning_objective = LearningObjective.find_by("description ILIKE ?", "%#{desc}%")

      if learning_objective.present?
        tag = TaxonomyTag.find_by(abbreviation: entry["abbreviation"])
        learning_objective.taxonomy_tags << tag
      else
        failed_count += 1
        # failed << [entry['objective'],entry['abbreviation']]
      end
    end

    # File.write("failed.csv", failed.map(&:to_csv).join)
    puts "Total failed: #{failed_count}"
  end

  desc "Populates the order based on the table structure"
  task set_order: :environment do
    lessons = Lesson.all

    lessons.each do |lesson|
      lesson.learning_objectives.each_with_index do |learning_objective, lo_index|
        learning_objective.order = lo_index + 1

        learning_objective.success_criteria.each_with_index do |success_criterion, sc_index|
          success_criterion.order = sc_index + 1
        end

        learning_objective.save!
      end
    end
  end

  def add_primary_lesson_objectives(lesson)
    # Primary format is a string which needs to be converted to the objective
    # followed by list that needs to become the success criteria:

    # To design a project that uses inputs and outputs on a controllable device:

    # * I can decide what variables to include in a project
    # * I can design the algorithm for my project
    # * I can design the program flow for my project

    objective_string = lesson.objectives.gsub("\r\n", "")

    objective, criteria_string = objective_string.split(":")
    criteria = criteria_string.split("* ").reject { |c| c.blank? }.map(&:strip)

    learning_objective = LearningObjective.new(description: objective, lesson: lesson)
    criteria.each do |criterion|
      learning_objective.success_criteria << SuccessCriterion.new(description: criterion)
    end

    learning_objective.save!
  end

  def add_secondary_lesson_objectives(lesson)
    # Secondary format is a list that needs to become the objectives:

    # * Explain the difference between a function and a procedure
    # * Use trace tables to investigate functions
    # * Use functions to return values in programs

    objectives_string = lesson.objectives.gsub("\r\n", "")
    objectives = objectives_string.split("* ").reject { |c| c.blank? }.map(&:strip)
    objectives.each do |objective|
      LearningObjective.create!(description: objective, lesson: lesson)
    end
  end
end
