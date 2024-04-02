class SetIBelongFlagToFalseForUsingMediaGainingSupportForACauseUnit < ActiveRecord::Migration[6.1]
  def change
    affected_unit = Unit.find_by(slug: "using-media-gaining-support-for-a-cause")

    return if affected_unit.blank?

    affected_unit.update!(display_i_belong_flag: false)
  end
end
