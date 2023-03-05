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

        Pusher.trigger("user#{user_id}", 'nocti', 
            user: "user#{by_user_id}"
        )
    end
end
