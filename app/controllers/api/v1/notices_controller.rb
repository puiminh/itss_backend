# Vu Tuan Kiet
class Api::V1::NoticesController < ApplicationController
    
    def index
        @notices = Notice.all
        render :index, status: :ok
    end

    def notices_user
        notices = Notice.where(user_id: params[:user_id])
        notices = notices.map do |notice|
            {
                notice: notice,
                user: notice.from_user
            }
        end
        render json: { 
            notices: notices
        }, status: :ok
    end

    def user_seen_all
        notices = Notice.where(user_id: params[:user_id])
        notices.each do |notice|
            notice.update_attribute(:seen, 1)
        end
        render json: {
            message: "All notices have been marked as seen"
        }, status: :ok
    end
end
