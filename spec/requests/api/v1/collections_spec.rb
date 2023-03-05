require 'swagger_helper'

RSpec.describe 'api/v1/collections', type: :request do

  path '/api/v1/collections/recommended' do

    get('recommended_collections collection') do
      tags 'Collections'
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

  path '/api/v1/collections/last_week' do

    get('new_collections_last_week collection') do
      tags 'Collections'
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

  path '/api/v1/collections/total' do

    get('total collection') do
      tags 'Collections'
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

  path '/api/v1/collections/created/{user_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user id'

    get('created_collections collection') do
      tags 'Collections'
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

  path '/api/v1/collections/courses/{collection_id}' do


    put('update_collection_courses collection') do
      tags 'Collections'
      consumes 'application/json'
      parameter name: 'collection_id', in: :path, type: :string, description: 'collection_id'      
      parameter name: :update_collection_courses, in: :body, schema: {
        type: :object,
        properties: {
          collection: { type: :object,
          properties: {
            title: { type: :string },
            desc: {type: :string}
          }
          },
          courses: { type: :array, items: { type: :integer} }
        },
        required: [ 'collection', 'course' ]
      }
      response(200, 'successful') do
        let(:collection_id) { '123' }

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

  path '/api/v1/collections/{collection_id}/{by_user_id}' do

    delete 'Delete a collection' do
        tags 'Collections'
        produces 'application/json'
        parameter name: :collection_id, in: :path, type: :string
        parameter name: :by_user_id, in: :path, type: :string
        response '200', 'Deleted collection' do
            let!(:collection_id) {create(:collection).id}
            let!(:by_user_id) {create(:user).id}
            run_test! do |res|
                expect(response).to have_http_status(200)
                expect(response_body["message"]).to eq("success")

                expect(Notice.count).to eq(1)
            end
        end
    end
  end

  path '/api/v1/collections' do

    get('list collections') do
      tags 'Collections'
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

    post('create collection') do
      tags 'Collections'
      consumes 'application/json'
      parameter name: :collection, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :object },
          desc: {  type: :string },
          image: { type: :string },
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

  path '/api/v1/collections/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show collection') do
      tags 'Collections'
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

    put('update collection') do
      tags 'Collections'
      consumes 'application/json'    
      parameter name: :collection, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          desc: {  type: :string },
          image: { type: :string }
          }
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
