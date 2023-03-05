require 'swagger_helper'

RSpec.describe 'Comment API', type: :request do
    path '/api/v1/comments' do
        get 'Get all comments' do
            tags 'Comments'
            produces 'application/json'

            response '200', 'Get all comments' do
                run_test!
            end
        end

        post 'Create new comment' do
            tags 'Comments'
            consumes 'application/json'
            parameter name: :comment, in: :body, schema: {
                type: :object,
                properties: {
                  content: { type: :string },
                  user_id: { type: :integer },
                  course_id: {type: :integer}
                },
                required: [ 'user_id', 'content', 'course_id' ]
              }
            request_body_example value: { content: 'Foo',
                user_id: 1, course_id: 2 }, name: 'example', summary: 'Request example description'
            response '201', 'Create new comment' do
                let(:comment) { build(:comment) do |comment|
                    comment.course = create :course
                    comment.user  = create :user
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

    path '/api/v1/comments/course/{course_id}'do
        get 'Get all course comments' do 
            tags 'Comments'
            produces 'application/json'
            parameter name: :course_id, in: :path, type: :string

            response '200', 'Get all course comments' do
                let(:course_id) {create(:comment).course.id}
                run_test! 
            end
        end
    end

    path '/api/v1/comments/last_week' do
        get 'Get new user information for the week' do 
            tags 'Comments'
            produces 'application/json'

            response '200', 'Get new user information for the week' do
                run_test!
            end
        end
    end

    path '/api/v1/comments/total' do
        get 'Total comments' do 
            tags 'Comments'
            produces 'application/json'

            response '200', 'Total comments' do
                run_test!
            end
        end
    end

    path '/api/v1/comments/{comment_id}/{by_user_id}' do

        delete 'Delete a comment' do
            tags 'Comments'
            produces 'application/json'
            parameter name: :comment_id, in: :path, type: :string
            parameter name: :by_user_id, in: :path, type: :string
            response '200', 'Deleted comment' do
                let(:comment_id) {create(:comment).id}
                let(:by_user_id) {create(:user).id}
                run_test! do |res|
                    expect(response).to have_http_status(200)
                    expect(Notice.count).to eq(1)
                end
            end
        end
    end

    path '/api/v1/comments/{id}' do
        # You'll want to customize the parameter types...
        parameter name: 'id', in: :path, type: :string, description: 'id'
    
        get('show comment') do
          tags 'Comments'
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
        
        put('update comment') do
          tags 'Comments'
          consumes 'application/json'
          parameter name: :comment, in: :body, schema: {
            type: :object,
            properties: {
              content: { type: :string },
              user_id: { type: :integer },
              course_id: {type: :integer}
            },
            required: [ 'user_id', 'content', 'course_id' ]
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
