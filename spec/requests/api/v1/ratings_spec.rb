require 'swagger_helper'

RSpec.describe 'api/v1/ratings', type: :request do

  path '/api/v1/ratings/course/{course_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'

    get('course_rating rating') do
      tags 'Ratings'
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

  path '/api/v1/ratings' do

    get('list ratings') do
      tags 'Ratings'
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

    post 'Rating course' do
      tags 'Ratings'
      consumes 'application/json'
      parameter name: :rating, in: :body, schema: {
          type: :object,
          properties: {
            star: { type: :integer },
            user_id: { type: :integer },
            course_id: { type: :integer}
          },
          required: [ 'star', 'user_id', 'course_id' ]
        } 

      response '201', 'Rated course' do
          let(:rating) { build :rating do |rating|
              rating.course = create :course
              rating.user = create :user
          end
          }
          let!(:count_noti) {Notice.count}
          run_test! do |res|
              expect(response).to have_http_status(201)
              expect(Notice.count).to eq(count_noti+1)
          end
      end
    end
  end

  path '/api/v1/ratings/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show rating') do
      tags 'Ratings'
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

    put('update rating') do
      tags 'Ratings'
      consumes 'application/json'
      parameter name: :rating, in: :body, schema: {
          type: :object,
          properties: {
            star: { type: :integer },
            user_id: { type: :integer },
            course_id: { type: :integer}
          },
          required: [ 'star', 'user_id', 'course_id' ]
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

    delete('delete rating') do
      tags 'Ratings'
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
