require 'swagger_helper'

RSpec.describe 'Collections Api', type: :request do
    path '/api/v1/collections' do
        get 'Get all collections' do
            tags 'Collections'
            produces 'application/json'

            response '200', 'Get all comments' do
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
end
