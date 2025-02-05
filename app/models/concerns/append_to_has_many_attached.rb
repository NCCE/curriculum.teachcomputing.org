# Based upon proposed solution to the replace on assign to many issue in the highlighted below repo
# https://github.com/Dreamersoul/administrate-field-active_storage

module AppendToHasManyAttached
  extend ActiveSupport::Concern

  class_methods do
    def has_many_attached_with_append(field)
      has_many_attached(field)

      field = field.to_s
      define_method :"#{field}=" do |attachables|
        attachables = Array(attachables).compact_blank

        if attachables.any?
          attachment_changes[field] =
            ActiveStorage::Attached::Changes::CreateMany.new(field, self, public_send(field).public_send(:blobs) + attachables)
        end
      end
    end
  end
end
