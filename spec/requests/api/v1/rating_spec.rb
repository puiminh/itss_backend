require 'swagger_helper'

RSpec.describe 'api/v1/rating', type: :request do
    path '/api/v1/ratings' do
        get 'Get all ratings' do
            tags 'Ratings'
            produces 'application/json'

            response '200', 'Get all ratings' do
                run_test!
            end
        end
    end

    path '/api/v1/ratings' do 
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
end
