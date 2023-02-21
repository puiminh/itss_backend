class Api::V1::UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.save
            render :create, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def new_users_last_week
        render json: User.where(
            'created_at >= :last_week',
            :last_week  => Time.now - 7.days
        ), status: :ok
    end

    def total
        render json: {total: User.count}, status: :ok
    end

    def created_courses_collections
        user = User.find(params[:user_id])
        render json: {
            collections: user.collections,
            courses: user.courses
        }
    end

    def bookmarked_courses_collections
        user = User.find(params[:user_id])
        render json: {
            bookmark_collections: user.bookmark_collections,
            bookmark_courses: user.bookmark_courses
        }
    end

    private

    def user_params
        params.require(:user).permit(:email,:password,:password_confirmation)
    end
end
