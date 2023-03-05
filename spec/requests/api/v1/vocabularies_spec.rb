require 'swagger_helper'

RSpec.describe 'api/v1/vocabularies', type: :request do

  path '/api/v1/vocabularies/need/{user_id}/{course_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'

    get('need_learn vocabulary') do
      tags 'Vocabularies'
      response(200, 'successful') do
        let(:user_id) { '123' }
        let(:course_id) { '123' }

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

  path '/api/v1/vocabularies' do

    get('list vocabularies') do
      tags 'Vocabularies'
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

    post('create vocabulary') do
      tags 'Vocabularies'
      consumes 'application/json'
      parameter name: :Vocabulary, in: :body, schema: {
        type: :object,
        properties: {
          word: { type: :string },
          define: { type: :string},
          link: {type: :string},
          kind: {type: :string},
          course_id: { type: :integer }
        },
        required: [ 'word', 'course_id', 'define' ]
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

  path '/api/v1/vocabularies/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show vocabulary') do
      tags 'Vocabularies'
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

    put('update vocabulary') do
      tags 'Vocabularies'
      consumes 'application/json'
      parameter name: :Vocabulary, in: :body, schema: {
        type: :object,
        properties: {
          word: { type: :string },
          define: { type: :string},
          link: {type: :string},
          kind: {type: :string},
          course_id: { type: :integer }
        },
        required: [ 'word', 'course_id', 'define' ]
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

    delete('delete vocabulary') do
      tags 'Vocabularies'
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
