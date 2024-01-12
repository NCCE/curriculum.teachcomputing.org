require "rails_helper"
require Rails.root.join "spec/system/admin/administrate_publishable_shared_examples.rb"

RSpec.describe "Unit publishing", type: :system do
  include_examples "administrate publishable", :unit
end
