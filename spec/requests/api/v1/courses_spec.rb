require 'swagger_helper'

RSpec.describe 'api/v1/courses', type: :request do

  path '/api/v1/courses/recent/{user_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user id'

    get('recent course') do
      tags 'Courses'
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

  path '/api/v1/courses/recommended' do

    get('recommended_courses course') do
      tags 'Courses'
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

  path '/api/v1/courses/last_week' do

    get('new_courses_last_week course') do
      tags 'Courses'
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

  path '/api/v1/courses/total' do

    get('total course') do
      tags 'Courses'
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

  path '/api/v1/courses/{course_id}/random_list_word' do
    # You'll want to customize the parameter types...
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'

    get('random_list_word course') do
      tags 'Courses'
      response(200, 'successful') do
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

  path '/api/v1/courses/created/{user_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('created_courses course') do
      tags 'Courses'
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

  path '/api/v1/courses/duplicate/{user_id}' do
    post 'duplicate course' do
        tags 'Courses'
        consumes 'application/json'
        parameter name: :user_id, in: :path, type: :integer
        parameter name: :course, in: :body, schema: {
            type: :object,
            properties: {
              course_id: { type: :integer }
            },
            required: ['course_id']
          }

        response '201', 'Duplicated course' do
            let(:notice_count) {Notice.count}
            run_test! do |res|
                expect(Notice.count).to eq(notice_count+1)
            end
        end
    end
end

  path '/api/v1/courses/vocabularies' do

    post('course_with_vocabularies course') do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course_voca, in: :body, schema: {
        type: :object,
        properties: {
          course: { type: :object,
          properties:{
            title: { type: :string},
            desc: {type: :string},
            author_id: {type: :integer}
          } },
          vocabs: { type: :array,
          items: { type: :object, 
            properties: {
              word: {type: :string},
              link: {type: :string},
              define: {type: :string},
              kind: {type: :integer}
            }
          }
          }
        },
        required: [ 'course', 'vocabs' ]
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

  path '/api/v1/courses/vocabularies/{course_id}' do



    put('Update course vocabularies') do
      tags 'Courses'
      parameter name: 'course_id', in: :path, type: :string, description: 'course id'
      consumes 'application/json'
      parameter name: :course_voca, in: :body, schema: {
        type: :object,
        properties: {
          course: { type: :object,
          properties:{
            title: { type: :string},
            desc: {type: :string}
          } },
          vocabs: { type: :array,
          items: { type: :object, 
            properties: {
              word: {type: :string},
              link: {type: :string},
              define: {type: :string},
              kind: {type: :integer}
            }
          }
          }
        },
        required: [ 'course', 'vocabs' ]
      }

      response(200, 'successful') do
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

  path '/api/v1/courses/{course_id}/{by_user_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'
    parameter name: 'by_user_id', in: :path, type: :string, description: 'by_user_id'

    delete('delete course with notify') do
      tags 'Courses'
      response(200, 'successful') do
        let(:course_id) { '123' }
        let(:by_user_id) { '123' }

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

  path '/api/v1/courses' do

    get('list courses') do
      tags 'Courses'
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

    post('create course') do
      tags 'Courses'
      consumes 'apllication/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          desc: { type: :string },
          author_id: {type: :integer}
        },
        required: [ 'title', 'author_id' ]
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

  path '/api/v1/courses/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'user id'

    get('show course') do
      tags 'Courses'
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

    put('update course') do
      tags 'Courses'
      consumes 'apllication/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          desc: { type: :string }
        },
        required: [ 'title']
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
  end
end
