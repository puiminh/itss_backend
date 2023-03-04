require 'swagger_helper'

RSpec.describe 'Course API', type: :request do
    let!(:course1) {create :course}
    let!(:course2) {create :course}
    let!(:course3) {create :course}
    
    path '/api/v1/courses' do
        get 'Get all courses' do
            tags 'course'
            produces 'application/json'

            response '200', 'Get all courses' do
                run_test!
            end
        end
    end


    path '/api/v1/courses/{course_id}/{by_user_id}' do
        delete 'delete a course' do
            tags 'course'
            consumes 'application/json'
            parameter name: :course_id, in: :path, type: :string
            parameter name: :by_user_id, in: :path, type: :string
    
            response '200', 'course deleted' do
                let(:by_user_id) {User.last.id}
                let(:course_id) {course2.id}
                
                run_test! do |res|
                    expect(
                        Course.count
                    ).to eq(2)
                    expect(Notice.count).to eq(1)
                    expect(Notice.first.from).to eq(by_user_id)  
                    expect(response).to have_http_status(:success)
                end
            end
        end
    end

end
