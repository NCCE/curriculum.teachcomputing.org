require "administrate/field/base"

class NestedHasManyField < Administrate::Field::Base
  def to_s
    data
  end
end
