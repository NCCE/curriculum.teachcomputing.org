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

  def add_primary_lesson_objectives(lesson)
    # Primary format is a string which needs to be converted to the objective
    # followed by list that needs to become the success criteria:

    # To design a project that uses inputs and outputs on a controllable device:

    # * I can decide what variables to include in a project
    # * I can design the algorithm for my project
    # * I can design the program flow for my project

    objective_string = lesson.objectives.gsub("\r\n", "")

    objective, criteria_string = objective_string.split(':')
    criteria = criteria_string.split('* ').reject { |c| c.blank? }.map(&:strip)

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
    objectives = objectives_string.split('* ').reject { |c| c.blank? }.map(&:strip)
    objectives.each do |objective|
      LearningObjective.create!(description: objective, lesson: lesson)
    end
  end
end
