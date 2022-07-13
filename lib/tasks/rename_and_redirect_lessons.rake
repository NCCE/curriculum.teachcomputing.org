task rename_and_redirect_lessons: :environment do
  lessons = Lesson.all

  lessons.each do |lesson|
    break unless lesson.title == 'Lesson 2 Computer systems and us'

    from = lesson.slug
    matches = /Lesson\s(\d+)\s(.+)/.match(lesson.title)
    lesson.update(order: matches[1], title: matches[2], slug: matches[2].parameterize)

    # Create a redirect and skip validation
    redirect = Redirect.new(from: from, redirectable: lesson, to: lesson.slug)
    redirect.save(validate: false)
  end
end
