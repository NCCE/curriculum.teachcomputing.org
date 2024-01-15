module Types
  class QueryType < BaseObject
    # Key stages

    field :key_stages, [Types::KeyStageType], null: true do
      argument :limit, Integer, required: false
    end

    def key_stages(**args)
      KeyStage.published.ordered.limit(args[:limit])
    end

    field :key_stage, Types::KeyStageType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    def key_stage(**args)
      find_record(KeyStage, args)
    end

    # Year groups

    field :year_groups, [Types::YearGroupType], null: true do
      argument :limit, Integer, required: false
    end

    def year_groups(**args)
      YearGroup.published.limit(args[:limit])
    end

    field :year_group, Types::YearGroupType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
    end

    def year_group(**args)
      find_record(YearGroup, args)
    end

    # Units

    field :units, [Types::UnitType], null: true do
      argument :limit, Integer, required: false
    end

    def units(**args)
      Unit.published.ordered.limit(args[:limit])
    end

    field :unit, Types::UnitType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
      argument :key_stage_slug, String, required: false
    end

    def unit(**args)
      find_record(Unit, args)
    end

    # Lessons

    field :lessons, [Types::LessonType], null: true do
      argument :limit, Integer, required: false
    end

    def lessons(**args)
      Lesson.published.ordered.limit(args[:limit])
    end

    field :lesson, Types::LessonType, null: true do
      argument :id, ID, required: false
      argument :slug, String, required: false
      argument :unit_slug, String, required: false
    end

    def lesson(**args)
      raise ArgumentError, "Missing parameter: unitSlug" if args[:slug] && !args[:unit_slug]

      find_record(Lesson, args)
    end

    # Redirects

    field :redirects, [Types::RedirectType], null: true do
      argument :limit, Integer, required: false
    end

    def redirects(**_args)
      Redirect.all || []
    end

    field :redirect, Types::RedirectType, null: true do
      argument :from, String, required: false
      argument :from_context, String, required: false
      argument :to, String, required: false
    end

    def redirect(**args)
      from, from_context, to = args.values_at(:from, :from_context, :to)
      find_redirect(from, from_context, to) || nil
    end

    def find_redirect(from, from_context, to)
      return Redirect.find_by(from: from, from_context: from_context) if from && from_context
      return Redirect.find_by(to: to) if to
      Redirect.find_by(from: from, from_context: from_context, to: to) if from && from_context && to
    end

    # Shared

    def find_record(model, args)
      id, slug, unit_slug, key_stage_slug = args.values_at(:id, :slug, :unit_slug, :key_stage_slug)

      if id
        record = model.find(id)
      elsif slug
        case model.model_name
        when "Lesson"
          record = Lesson.published.find { |l| l.slug == slug && l.unit.slug == unit_slug }
        when "Unit"
          key_stage = KeyStage.find_by(slug: key_stage_slug)
          year_groups = YearGroup.where(key_stage_id: key_stage.id)

          record = Unit.published.find_by(slug: slug, year_group: year_groups.pluck(:id))
        else
          record = model.find_by!(slug: slug)
        end
      end

      raise ActiveRecord::RecordNotFound if record.blank?

      record
    end
  end
end
