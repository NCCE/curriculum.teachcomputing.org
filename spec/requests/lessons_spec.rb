require 'rails_helper'

RSpec.describe 'Lesson', type: :request do
  describe 'for a primary lesson' do
    let!(:published_lesson) { create(:published_lesson) }
    let!(:primary_learning_objectives) do
      [
        create(:learning_objective, lesson: published_lesson, order: 2, description: 'MyString 2'),
        create(:learning_objective, lesson: published_lesson, order: 1, description: 'MyString 1')
      ]
    end

    before do
      post '/graphql', params: {
        query: <<~GQL
          {
            lessons
              {
                id
                unit {
                  id
                }
                title
                slug
                description
                isaacUrl
                learningObjectives {
                  description
                  successCriteria {
                    description
                  }
                }
              }
          }
        GQL
      }
    end

    it 'returns lessons with the expected learning objectives' do
      expect(response).to be_successful

      expected_response = {
        data: {
          lessons: [{
            id: published_lesson.id,
            unit: {
              id: published_lesson.unit.id
            },
            title: published_lesson.title,
            slug: published_lesson.slug,
            description: published_lesson.description,
            isaacUrl: published_lesson.isaac_url,
            learningObjectives: [
              {
                description: 'MyString 1',
                successCriteria: []
              },
              {
                description: 'MyString 2',
                successCriteria: []
              }
            ]
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end

  describe 'for a secondary lesson' do
    let!(:published_lesson) { create(:published_lesson) }
    let!(:secondary_learning_objective) do
      create(:learning_objective, lesson: published_lesson)
    end

    let!(:secondary_success_criteria) do
      [
        create(:success_criterion, description: 'MyString 3', order: '2',
                                   learning_objective: secondary_learning_objective),
        create(:success_criterion, description: 'MyString 1', order: '3',
                                   learning_objective: secondary_learning_objective),
        create(:success_criterion, description: 'MyString 2', order: '1',
                                   learning_objective: secondary_learning_objective)
      ]
    end

    before do
      post '/graphql', params: {
        query: <<~GQL
          {
            lessons
              {
                id
                unit {
                  id
                }
                title
                slug
                description
                learningObjectives {
                  description
                  successCriteria {
                    description
                  }
                }
              }
          }
        GQL
      }
    end

    it 'returns lessons with the expected success criteria' do
      expect(response).to be_successful

      expected_response = {
        data: {
          lessons: [{
            id: published_lesson.id,
            unit: {
              id: published_lesson.unit.id
            },
            title: published_lesson.title,
            slug: published_lesson.slug,
            description: published_lesson.description,
            learningObjectives: [
              {
                description: 'MyString',
                successCriteria: [
                  {
                    description: 'MyString 2'
                  },
                  {
                    description: 'MyString 3'
                  },
                  {
                    description: 'MyString 1'
                  }
                ]
              }
            ]
          }]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end

  describe 'where multiple lessons share the same slug but a different unit' do
    let!(:published_lesson) { create(:published_lesson) }
    let!(:published_lesson_2) { create(:published_lesson, unit: create(:unit)) }

    before do
      post '/graphql', params: {
        query: <<~GQL
          {
            lesson(slug: "#{published_lesson.slug}", unitSlug: "#{published_lesson.unit.slug}")
              {
                id
                slug
                unit {
                  id
                  slug
                }
              }
          }
        GQL
      }
    end

    it 'returns the expected lesson' do
      expect(response).to be_successful

      expected_response = {
        data: {
          lesson: {
            id: published_lesson.id,
            slug: published_lesson.slug,
            unit: {
              id: published_lesson.unit.id,
              slug: published_lesson.unit.slug
            }
          }
        }
      }.to_json

      expect(response.body).to eq(expected_response)
      response_obj = JSON.parse(response.body, object_class: OpenStruct)
      expect(response_obj.data.lesson.unit.slug).not_to eq(published_lesson_2.unit.slug)
    end
  end

  describe 'where a redirect has been defined for a lesson' do
    let!(:unpublished_lesson) { create(:lesson, unit: create(:unit)) }
    let!(:published_lesson_2) do
      create(:published_lesson, unit: create(:unit), state: create(:published_state))
    end
    let!(:redirect) { create(:redirect, from: unpublished_lesson.slug, redirectable: published_lesson_2) }

    before do
      post '/graphql', params: {
        query: <<~GQL
          {
            lesson(slug: "#{published_lesson_2.slug}", unitSlug: "#{published_lesson_2.unit.slug}")
              {
                id
                slug
                unit {
                  id
                  slug
                }
                redirects {
                  from
                  to
                }
              }
          }
        GQL
      }
    end

    it 'returns the redirect' do
      expect(response).to be_successful

      expected_response = {
        data: {
          lesson: {
            id: published_lesson_2.id,
            slug: published_lesson_2.slug,
            unit: {
              id: published_lesson_2.unit.id,
              slug: published_lesson_2.unit.slug
            },
            redirects: [{
              from: redirect.from,
              to: redirect.to
            }]
          }
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end

  describe 'when ordering' do
    let!(:lesson_2) { create(:published_lesson, order: 1, title: 'Lesson 2') }
    let!(:lesson_3) { create(:published_lesson, order: 3, title: 'Lesson 3') }
    let!(:lesson_1) { create(:published_lesson, order: 2, title: 'Lesson 1') }

    before do
      post '/graphql', params: {
        query: <<~GQL
          {
            lessons
              {
                slug
                order
              }
          }
        GQL
      }
    end

    it 'returns lessons in the defined order' do
      expect(response).to be_successful

      expected_response = {
        data: {
          lessons: [
            {
              slug: lesson_2.slug,
              order: 1
            },
            {
              slug: lesson_1.slug,
              order: 2
            },
            {
              slug: lesson_3.slug,
              order: 3
            }
          ]
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
