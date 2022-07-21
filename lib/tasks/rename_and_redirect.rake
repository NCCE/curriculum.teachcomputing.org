namespace :rename_and_redirect do
  desc 'Removes the lesson number from lesson titles, store it and creates a redirect'
  task lessons: :environment do
    lessons = Lesson.all

    lessons.each do |lesson|
      from = lesson.slug

      # matches 'Lesson 31 and 32 A lessonium' 'Lesson 1 A lessonium'
      matches = /Lesson\s(\d+)\s(?:and\s(\d+)\s)?(.+)/.match(lesson.title)
      lesson.update(order: matches[1], range: matches[2] || nil, title: matches[3], slug: matches[3].parameterize)

      # Create a redirect and skip validation
      redirect = Redirect.new(from: from, redirectable: lesson, to: lesson.slug)
      redirect.save(validate: false)
    end
  end

  desc 'Adds ordering to units'
  task units: :environment do
    failed = []

    units = Unit.all

    ordering = {
      y1: [
        'computing-systems-and-networks-technology-around-us',
        'creating-media-digital-painting',
        'programming-a-moving-a-robot',
        'data-and-information-grouping-data',
        'creating-media-digital-writing',
        'programming-b-introduction-to-animation'
      ],
      y2: [
        'computing-systems-and-networks-it-around-us',
        'creating-media-digital-photography',
        'programming-a-robot-algorithms',
        'data-and-information-pictograms',
        'creating-media-making-music',
        'programming-b-an-introduction-to-quizzes'
      ],
      y3: [
        'computing-systems-and-networks-connecting-computers',
        'creating-media-animation',
        'programming-a-sequence-in-music',
        'data-and-information-branching-databases',
        'creating-media-desktop-publishing',
        'programming-b-events-and-actions'
      ],
      y4: [
        'computing-systems-and-networks-the-internet',
        'creating-media-audio-editing',
        'programming-a-repetition-in-shapes',
        'data-and-information-data-logging',
        'creating-media-photo-editing',
        'programming-b-repetition-in-games'
      ],
      y5: [
        'computing-systems-and-networks-sharing-information',
        'creating-media-video-editing',
        'programming-a-selection-in-physical-computing',
        'data-and-information-flat-file-databases',
        'creating-media-vector-drawing',
        'programming-b-selection-in-quizzes'
      ],
      y6: [
        'computing-systems-and-networks-communication',
        'creating-media-web-page-creation',
        'programming-a-variables-in-games',
        'data-and-information-spreadsheets',
        'creating-media-3d-modelling',
        'programming-b-sensing'
      ],
      y7: [
        'impact-of-technology-collaborating-online-respectfully',
        'networks-from-semaphores-to-the-internet',
        'using-media-gaining-support-for-a-cause',
        'programming-essentials-in-scratch-part-i',
        'programming-essentials-in-scratch-part-ii',
        'modelling-data-spreadsheets'
      ],
      y8: %w[
        media-vector-graphics
        computing-systems
        developing-for-the-web
        representations-from-clay-to-silicon
        mobile-app-development
        introduction-to-python-programming
      ],
      y9: %w[
        python-programming-with-sequences-of-data
        media-animations
        data-science
        representations-going-audiovisual
        cybersecurity
        physical-computing
      ],
      ygcse: [
        'algorithms-part-1',
        'algorithms-part-2',
        'computer-systems',
        'data-representations',
        'programming-part-1-sequence',
        'programming-part-2-selection',
        'programming-part-3-iteration',
        'programming-part-4-subroutines',
        'programming-part-5-strings-and-lists',
        'cyber-security',
        'databases-and-sql',
        'html',
        'impacts-of-technology',
        'networks',
        'physical-computing-project',
        'programming-part-6-dictionaries-and-datafiles'
      ],
      'ynon-gcse': %w[
        online-safety
        it-and-the-world-of-work
        media
        spreadsheets
        it-project-management
        object-oriented-programming
      ]
    }

    ordering.each do |key, by_year|
      puts "Processing: #{key}"

      by_year.each_with_index do |slug, order|
        unit = units.find_by(slug: slug)
        failed.push(slug) unless unit

        unit.update(order: (order + 1))
      end
    end

    puts 'Unable to process:', failed unless failed.blank?
  end
end
