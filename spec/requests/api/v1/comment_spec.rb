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
                run_test! do |res|
                    
                    expect(response).to have_http_status(201)
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
end
