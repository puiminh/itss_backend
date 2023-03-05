require 'swagger_helper'

RSpec.describe 'api/v1/collections_courses', type: :request do

  path '/api/v1/collections/course' do

    post('add_course_to_collection collections_course') do
      tags 'Course collections'
      consumes 'application/json'
      parameter name: :course_collection, in: :body, schema: {
        type: :object,
        properties: {
          course_id: { type: :integer },
          collection_id: { type: :integer }
        },
        required: [ 'course_id', 'collection_id' ]
      }
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
  end

  path '/api/v1/collections/courses' do

    post('collection_with_courses collections_course') do
      tags 'Course collections'
      consumes 'application/json'
      parameter name: :course_collection, in: :body, schema: {
        type: :object,
        properties: {
          collection: { type: :object, 
            properties: {
              title: { type: :string },
              desc: { type: :string },
              image: { type: :string },
              author_id: { type: :integer }
            }

           },
          courses: { type: :array, 
            items: {type: :integer}
          }
        },
        required: [ 'collection', 'courses' ]
      }
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
  end

  path '/api/v1/courses_collections/{type}/{keyword}' do
    # You'll want to customize the parameter types...
    parameter name: 'type', in: :path, type: :string, description: 'type'
    parameter name: 'keyword', in: :path, type: :string, description: 'keyword'

    get('keyword_find collections_course') do
      tags 'Course collections'
      response(200, 'successful') do
        let(:type) { '123' }
        let(:keyword) { '123' }

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

  path '/api/v1/collections_courses' do

    get('list collections_courses') do
      tags 'Course collections'
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

    post('create collections_course') do
      tags 'Course collections'
      consumes 'application/json'
      parameter name: :course_collection, in: :body, schema: {
        type: :object,
        properties: {
          course_id: { type: :integer },
          collection_id: { type: :integer }
        },
        required: [ 'course_id', 'collection_id' ]
      }
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
  end

  path '/api/v1/collections_courses/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show collections_course') do
      tags 'Course collections'
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


    put('update collections_course') do
      tags 'Course collections'
      consumes 'application/json'
      parameter name: :course_collection, in: :body, schema: {
        type: :object,
        properties: {
          course_id: { type: :integer },
          collection_id: { type: :integer }
        },
        required: [ 'course_id', 'collection_id' ]
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

    delete('delete collections_course') do
      tags 'Course collections'
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
