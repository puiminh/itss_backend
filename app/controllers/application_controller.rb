class ApplicationController < ActionController::API
    def save_notice(user_id, by_user_id, msg)
        notice = Notice.new({
            user_id: user_id,
            from: by_user_id,
            message: msg
        })
        
        if user_id != by_user_id 
            notice.save!    
        end
    end
end
