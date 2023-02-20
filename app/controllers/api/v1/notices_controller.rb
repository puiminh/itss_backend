# Vu Tuan Kiet
class Api::V1::NoticesController < ApplicationController
    def notices_user
        render json: { 
            notices: Notice.find_by(user_id: params[:user_id])
        }, status: :ok
    end
end
