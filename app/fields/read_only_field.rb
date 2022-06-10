require "administrate/field/base"

class ReadOnlyField < Administrate::Field::Base
  def to_s
    data
  end
end
