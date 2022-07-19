require 'rails_helper'
require 'administrate/field/select'

RSpec.describe 'fields/contextual_select_field/_form', type: :view do
  it 'displays the selected option and works as a simple select' do
    redirect = build(:redirect)
    select = instance_double(
      'ContextualSelectField',
      attribute: :from,
      data: false,
      selectable_options: [true, false, nil],
      include_blank_option: false
    )

    allow(select).to receive(:filtered_options).and_return([true, false, nil])

    render(
      partial: 'fields/contextual_select_field/form',
      locals: { field: select, f: form_builder(redirect) }
    )

    expect(rendered).to have_css(
      %(select[name="redirect[from]"]
        option[value="false"][selected="selected"])
    )
  end

  def form_builder(object)
    ActionView::Helpers::FormBuilder.new(
      object.model_name.singular,
      object,
      build_template,
      {}
    )
  end

  def build_template
    Object.new.tap do |template|
      template.extend ActionView::Helpers::FormHelper
      template.extend ActionView::Helpers::FormOptionsHelper
    end
  end
end
