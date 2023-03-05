require 'swagger_helper'

RSpec.describe 'api/v1/progresses', type: :request do

  path '/api/v1/progress/{course_id}/{user_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('user_progress_course progress') do
      tags 'Progresses'
      response(200, 'successful') do
        let(:course_id) { '123' }
        let(:user_id) { '123' }

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

  path '/api/v1/progress/{user_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('user_progress progress') do
      tags 'Progresses'
      response(200, 'successful') do
        let(:user_id) { '123' }

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

  path '/api/v1/progress/update' do

    post('update_progress progress') do
      tags 'Progresses'
      consumes 'application/json'
      parameter name: :progress, in: :body, schema: {
        type: :object,
        properties: {
          point: { type: :integer },
          user_id: { type: :integer },
          course_id: { type: :integer },
          vocabulary_id:{ type: :integer }
        },
        required: [ 'point', 'user_id','course_id', 'vocabulary_id' ]
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

  path '/api/v1/progresses' do

    get('list progresses') do
      tags 'Progresses'
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

    post('create progress') do
      tags 'Progresses'
      consumes 'application/json'
      parameter name: :progress, in: :body, schema: {
        type: :object,
        properties: {
          point: { type: :integer },
          user_id: { type: :integer },
          course_id: { type: :integer },
          vocabulary_id:{ type: :integer }
        },
        required: [ 'point', 'user_id','course_id', 'vocabulary_id' ]
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

  path '/api/v1/progresses/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show progress') do
      tags 'Progresses'
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

    put('update progress') do
      tags 'Progresses'
      consumes 'application/json'
      parameter name: :progress, in: :body, schema: {
        type: :object,
        properties: {
          point: { type: :integer },
          user_id: { type: :integer },
          course_id: { type: :integer },
          vocabulary_id:{ type: :integer }
        },
        required: [ 'point', 'user_id','course_id', 'vocabulary_id' ]
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

    delete('delete progress') do
      tags 'Progresses'
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
