require 'fuzzystringmatch'
require 'zip'

namespace :migration do
  task create_key_stages_and_year_groups: :environment do
    key_stage_one = KeyStage.find_or_create_by(level: '1') do |key_stage|
      key_stage.ages = '5-6'
      key_stage.years = '1-2'
      key_stage.description = 'Placeholder description'
    end

    key_stage_two = KeyStage.find_or_create_by(level: '2') do |key_stage|
      key_stage.ages = '7-10'
      key_stage.years = '3-6'
      key_stage.description = 'Placeholder description'
    end

    key_stage_three = KeyStage.find_or_create_by(level: '3') do |key_stage|
      key_stage.ages = '11-13'
      key_stage.years = '7-9'
      key_stage.description = 'Placeholder description'
    end

    key_stage_four = KeyStage.find_or_create_by(level: '4') do |key_stage|
      key_stage.ages = '14-15'
      key_stage.years = '10-11'
      key_stage.description = 'Placeholder description'
    end

    year_group_one = key_stage_one.year_groups.find_or_create_by(year_number: '1')
    year_group_one.published!

    year_group_two = key_stage_one.year_groups.find_or_create_by(year_number: '2')
    year_group_two.published!

    puts "KeyStage One YearGroups: #{key_stage_one.year_groups.count}"

    year_group_three = key_stage_two.year_groups.find_or_create_by(year_number: '3')
    year_group_three.published!

    year_group_four = key_stage_two.year_groups.find_or_create_by(year_number: '4')
    year_group_four.published!

    year_group_five = key_stage_two.year_groups.find_or_create_by(year_number: '5')
    year_group_five.published!

    year_group_six = key_stage_two.year_groups.find_or_create_by(year_number: '6')
    year_group_six.published!

    puts "KeyStage Two YearGroups: #{key_stage_two.year_groups.count}"

    year_group_seven = key_stage_three.year_groups.find_or_create_by(year_number: '7')
    year_group_seven.published!

    year_group_eight = key_stage_three.year_groups.find_or_create_by(year_number: '8')
    year_group_eight.published!

    year_group_nine = key_stage_three.year_groups.find_or_create_by(year_number: '9')
    year_group_nine.published!

    puts "KeyStage Three YearGroups: #{key_stage_three.year_groups.count}"

    year_group_ten_and_eleven = key_stage_four.year_groups.find_or_create_by(year_number: '10-11')
    year_group_ten_and_eleven.published!

    puts "KeyStage Four YearGroups: #{key_stage_four.year_groups.count}"
  end

  task create_units_and_lessons: :environment do
    ContentMigration.new.create_units_and_lessons
  end

  task create_zips: :environment do
    ContentMigration.new.create_zips
  end

  task attach_unit_docs: :environment do
    ContentMigration.new.attach_unit_docs
  end

  task attach_zips: :environment do
    ContentMigration.new.attach_zips
  end
end

class ContentMigration
  UNIT_FILE_TYPES = ['Learning graph –', 'Unit overview –', 'Summative assessment answers –', 'Assessment – ', 'Assessment answers –', 'Assessment questions –', 'Summative assessment questions –', 'Summative assessment –', 'Unit assessment rubric –'].freeze
  def initialize
    @lesson_count = 0
    @lessons_created_count = 0
    @unit_count = 0
    @units_created_count = 0
  end

  def create_units_and_lessons
    Dir.chdir("/app/tmp/years")
    years = get_folders(Dir.getwd)
    years.each do |year_directory|
      Dir.chdir(year_directory) do
        year = set_year(year_directory)
        units = get_folders(Dir.getwd)
        units.each do |unit_directory|
          @unit_count += 1
          unit_name = set_unit_name(unit_directory, year.year_number)
          if year.units.find_by(slug: unit_name.parameterize).nil?
            unit = year.units.create(title: unit_name, description: 'placeholder description')
            puts "Created Unit: #{unit.id} #{unit.title}"
            unit.published!
            @units_created_count += 1
          end

          unit = Unit.find_by(slug: unit_name.parameterize) if unit.nil?

          Dir.chdir(unit_directory) do
            lesson_folders = get_folders(Dir.getwd)
            puts "Creating Lessons for Unit: #{unit.title}"
            lesson_folders.each do |lesson_directory|
              lesson_title = determine_lesson_name(lesson_directory)
              @lesson_count += 1
              if unit.lessons.find_by(slug: lesson_title.parameterize).nil?
                lesson = unit.lessons.create(title: lesson_title, description: 'placeholder description')
                puts "Created Lesson: #{lesson.id} #{lesson.title}"
                lesson.published!
                @lessons_created_count += 1
              end
            end
          end
        end
      end
    end
    puts "Units found: #{@unit_count}"
    puts "Units created: #{@units_created_count}"
    puts "Lessons found: #{@lesson_count}"
    puts "Lessons created: #{@lessons_created_count}"
  end

  def attach_unit_docs
    Dir.chdir("/app/tmp/years")
    years = get_folders(Dir.getwd)
    years.each do |year_directory|
      Dir.chdir(year_directory) do
        year = set_year(year_directory)
        units = get_folders(Dir.getwd)

        units.each do |unit_directory|
          unit_name = set_unit_name(unit_directory, year.year_number)
          unit = Unit.find_by(slug: unit_name.parameterize)

          Dir.chdir(unit_directory) do
            puts "Attaching unit content for for #{unit.id}: #{unit.title}"
            files = get_files(Dir.getwd)
            next if unit.unit_documents_synced
            files.each do |file|
              field_type = determine_unit_file_type(file)
              case field_type
              when 'Learning graph –'
                puts "attaching #{field_type}"
                unit.learning_graphs.attach(io: File.open(file), filename: file)
              when 'Unit overview –'
                unit.unit_guide.attach(io: File.open(file), filename: file)
                puts "attaching #{field_type}"
              when 'Assessment answers –'
                unit.summative_answers.attach(io: File.open(file), filename: file)
                puts "attaching #{field_type}"
              when 'Summative assessment answers –'
                unit.summative_answers.attach(io: File.open(file), filename: file)
                puts "attaching #{field_type}"
              when 'Summative assessment questions –'
                unit.summative_assessments.attach(io: File.open(file), filename: file)
                puts "attaching #{field_type}"
              when 'Assessment questions –'
                unit.summative_assessments.attach(io: File.open(file), filename: file)
                puts "attaching #{field_type}"
              when 'Assessment – '
                unit.summative_assessments.attach(io: File.open(file), filename: file)
                puts "attaching #{field_type}"
              when 'Summative assessment –'
                unit.summative_assessments.attach(io: File.open(file), filename: file)
                puts "attaching #{field_type}"
              when 'Unit assessment rubric –'
                unit.rubrics.attach(io: File.open(file), filename: file)
                puts "attaching #{field_type}"
              else
                puts "Coudnt match #{file} for Unit #{unit.title}"
              end
            end
            unit.update(unit_documents_synced: true, unit_documents_synced_at: DateTime.now)
          end
        end
      end
    end
  end

  def create_zips
    Dir.chdir("/app/tmp/years")
    years = get_folders(Dir.getwd)
    years.each do |year_directory|
      Dir.chdir(year_directory) do
        units = get_folders(Dir.getwd)
        units.each do |unit_directory|
          Dir.chdir(unit_directory) do
            lesson_folders = get_folders(Dir.getwd)
            lesson_folders.each do |lesson_directory|
              lesson_title = determine_lesson_name(lesson_directory)
              lesson = Lesson.find_by(slug: lesson_title.parameterize)
              if lesson.nil?
                puts "CANNOT FIND LESSON: #{lesson_title.parameterize}"
                next
              end
              puts "Zipping step for #{lesson.id}: #{lesson.title}"
              unless File.exist?("#{Dir.getwd}/#{lesson_directory}.zip")
                puts "zipping #{lesson_directory}"
                zf = ZipFileGenerator.new(lesson_directory, "#{Dir.getwd}/#{lesson_directory}.zip")
                zf.write()
                puts "Zipped"
              end
            end
          end
        end
      end
    end
  end

  def attach_zips
    attached_count = 0
    Dir.chdir("/app/tmp/years")
    years = get_folders(Dir.getwd)
    years.each do |year_directory|
      Dir.chdir(year_directory) do
        units = get_folders(Dir.getwd)
        units.each do |unit_directory|
          Dir.chdir(unit_directory) do
            lesson_folders = get_folders(Dir.getwd)
            lesson_folders.each do |lesson_directory|
              lesson_title = determine_lesson_name(lesson_directory)
              lesson = Lesson.find_by(slug: lesson_title.parameterize)
              next if lesson.zip_synced
              if File.exist?("#{Dir.getwd}/#{lesson_directory}.zip")
                puts "Attaching zip step for #{lesson.id}: #{lesson.title} - unit #{lesson.unit.title}"
                if lesson.zipped_contents.attached?
                  puts "Skipping #{lesson.title} as zip is already attached"
                  next
                end
                lesson.zipped_contents.attach(io: File.open("#{Dir.getwd}/#{lesson_directory}.zip"), filename: "#{Dir.getwd}/#{lesson_directory}.zip")
                puts "Attached zip"
                attached_count += 1
                lesson.update(zip_synced: true, zip_synced_at: DateTime.now)
              else
                puts "No Zip for #{lesson.id}: #{lesson.title}"
              end
            end
          end
        end
      end
    end
    puts "Attached total zips: #{attached_count}"
  end

  def get_files(dir)
    Dir.entries(dir).select { |file| File.file?(File.join(dir, file)) }
  end

  def get_folders(dir)
    folders = Dir.entries(dir).select { |file| File.directory?(File.join(dir, file)) }
    folders.reject! { |folder| folder.start_with?('.') }
  end

  def set_year(level)
    return YearGroup.find_by(year_number: '10-11') if level.start_with?('KS4')
    YearGroup.find_by(year_number: level.delete_prefix("Y"))
  end

  def determine_lesson_name(dir)
    lesson_number = dir[1].to_i
    if dir.include?('–')
      "Lesson #{lesson_number} #{ dir.delete_prefix("L#{lesson_number} – ")}".tr('_', '')
    else
      "Lesson #{lesson_number} #{ dir.delete_prefix("L#{lesson_number} - ")}".tr('_', '')
    end
  end

  def set_unit_name(unit_directory, year_number)
    return unit_directory.delete_prefix("KS4 – ").tr('_', '') if unit_directory.start_with?('KS4')
    unit_directory.delete_prefix("Y#{year_number} – ").tr('_', '')
  end

  def determine_unit_file_type(file)
    file_type = file.partition('–').first
    matcher = FuzzyStringMatch::JaroWinkler.create(:pure)
    UNIT_FILE_TYPES.each do |known_file|
      result = matcher.getDistance(file_type, known_file)
      return known_file if result >= 0.90
      file
    end
  end
end

class ZipFileGenerator
  def initialize(input_dir, output_file)
    @input_dir = input_dir
    @output_file = output_file
  end

  def write
    entries = Dir.entries(@input_dir) - %w(. ..)

    ::Zip::File.open(@output_file, ::Zip::File::CREATE) do |io|
      write_entries entries, '', io
    end
  end

  private

  def write_entries(entries, path, io)
    entries.each do |e|
      zip_file_path = path == '' ? e : File.join(path, e)
      disk_file_path = File.join(@input_dir, zip_file_path)

      if File.directory? disk_file_path
        recursively_deflate_directory(disk_file_path, io, zip_file_path)
      else
        put_into_archive(disk_file_path, io, zip_file_path)
      end
    end
  end

  def recursively_deflate_directory(disk_file_path, io, zip_file_path)
    io.mkdir zip_file_path
    subdir = Dir.entries(disk_file_path) - %w(. ..)
    write_entries subdir, zip_file_path, io
  end

  def put_into_archive(disk_file_path, io, zip_file_path)
    io.get_output_stream(zip_file_path) do |f|
      f.puts(File.open(disk_file_path, 'rb').read)
    end
  end
end
