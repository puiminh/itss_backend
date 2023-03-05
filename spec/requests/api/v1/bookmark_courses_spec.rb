require 'swagger_helper'

RSpec.describe 'api/v1/bookmark_courses', type: :request do

  path '/api/v1/bookmark_courses' do
    
    get('list bookmark_courses') do
      tags 'Bookmark course'
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create bookmark_course') do
      tags 'Bookmark course'
      consumes 'application/json'
      parameter name: :bookmark_course, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          course_id: { type: :integer }
        },
        required: [ 'user_id', 'course_id' ]
      }

      response(200, 'successful') do
        let(:notice_count) {Notice.count}
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |res|
          expect(Notice.count).to eq(notice_count+1)
        end
      end
    end
  end

  path '/api/v1/bookmark_courses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show bookmark_course') do
      tags 'Bookmark course'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update bookmark_course') do
      tags 'Bookmark course'
      consumes 'application/json'
      parameter name: :bookmark_course, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          course_id: { type: :integer }
        },
        required: [ 'user_id', 'course_id' ]
      }
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete bookmark_course') do
      tags 'Bookmark course'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
