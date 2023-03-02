class Rating < ApplicationRecord

    after_save :nocti_to_user

    belongs_to :user
    belongs_to :course

    private
        def nocti_to_user
            puts "hello"
            puts self.course.author_id

            Pusher.trigger("user#{self.course.author_id}", 'nocti', 
                self.user
            )
        end

end
