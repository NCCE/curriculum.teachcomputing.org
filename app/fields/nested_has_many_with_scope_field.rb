# frozen_string_literal: true

require 'administrate/field/base'

class NestedHasManyWithScopeField < Administrate::Field::NestedHasMany
  #
  # This adds the `scope` option to a HasMany field.  This option should be a
  # proc, with a single argument that is the collection to be scoped.  E.g.
  #
  # HasManyWithScopeField.with_options(scope: ->(collection) { collection.kept })
  #
  # The scope is applied to the `@data` instance variable on initialize.  The
  # alternative was to extend the `#resources` or `#data` methods to apply the
  # scope, but these either required further changes to the views (using
  # `resources` where `data` was used), or meant re-applying the scope to the
  # `@data` ivar each time `#data` was called.
  def initialize(*)
    super

    @data = options[:scope].call(@data) if @data && options[:scope]
  end

  def to_s
    @data.name
  end
end
