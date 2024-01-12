require "rails_helper"
require Rails.root.join "spec/system/admin/administrate_publishable_shared_examples.rb"

RSpec.describe "KeyStage publishing", type: :system do
  include_examples "administrate publishable", :key_stage
end
