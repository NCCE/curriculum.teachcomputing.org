require 'rails_helper'

RSpec.describe 'KeyStage', type: :request do
  let!(:key_stage_with_guide) { create(:key_stage_with_guide) }

  it 'returns a teacher guide' do
    post '/graphql', params: {
      query: <<~GQL
        {
          keyStages
            {
              id
              teacherGuide {
                type
                filename
                size
                file
              }
            }
        }
      GQL
    }
    expect(response).to be_successful

    teacher_guide = key_stage_with_guide.teacher_guide

    expected_response = {
      data: {
        keyStages: [{
          id: key_stage_with_guide.id,
          teacherGuide: {
            type: 'PDF',
            filename: 'test.pdf',
            size: '0 Bytes',
            file: url_for(teacher_guide.attachment)
          }
        }]
      }
    }.to_json

    expect(response.body).to eq(expected_response)
  end
end
