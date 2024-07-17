require "administrate/field/base"

class PageLinkField < Administrate::Field::Base
  def to_s
    data
  end
end
