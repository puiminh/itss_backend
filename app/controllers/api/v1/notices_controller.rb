# Vu Tuan Kiet
class Api::V1::NoticesController < ApplicationController
    def notices_user
        notices = Notice.where(user_id: params[:user_id])
        notices = notices.map do |notice|
            {
                notice: notice,
                user: notice.user
            }
        end
        render json: { 
            notices: notices
        }, status: :ok
    end
end
