require 'swagger_helper'

RSpec.describe 'Notice API', type: :request do
    path '/api/v1/notices' do
        get 'Get all notice' do
            tags 'notice'
            produces 'application/json'

            response '200', 'Get all notices' do
                run_test!
            end
        end
    end
end
