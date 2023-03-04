require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user1) {create :user}
    let!(:user2) {create :user}

  path '/api/v1/users' do

    get 'Get all user' do
      tags 'user'
      produces 'application/json'

      response '200', 'Get all user' do
        schema type: :object,   
        properties: {
          data: {type: :array,
            items: {
                type: :object,
                properties: {
                    id: { type: :integer },
                    email: { type: :string },
                    user_name: { type: :string },
                    role: {type: :integer},
                    first_name: { type: :string },
                    last_name: { type: :string },
                    created_at: { type: :string },
                    updated_at: { type: :string },
                    avatar: { type: :string }
                }
            }
        }

        }

        

        run_test! do |response|
        @expected = {
            data: [user1, user2]
        }.to_json

        expect(response).to have_http_status(:success)
        
        expect(response_body["data"].size).to eq(2)
        expect(response.body).to eq(
            @expected
        )
        end
      end

    end
  end
end
