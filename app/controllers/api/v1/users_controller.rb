class Api::V1::UsersController < ApplicationController

    def create
        @user = User.new(user_params)
        if @user.save
            render json: {
                user: @user
            }, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])
        if user.destroy
            render json: {
                message: "success"
            }, status: 200      
        else
            render json: {
                message: "failure"
            }, status: 400      
        end
    end

    def index
        render json: {
            data: User.all
        }, status: 200
    end

    def update
        @user = User.find(params[:user_id])
        if @user.update(
                avatar: params[:avatar],
                first_name: params[:first_name],
                last_name: params[:last_name],
                role: params[:role]
            )
            render json: {
                user: @user,
                message: "success"
            }, status: 200
        else
            render json: {
                message: "error"
            }, status: 400
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
        collection_list = []
        course_list = []
        collections = user.collections
        courses = user.courses

        collections.each do |collection|
            collection_list << {
                collection: collection,
                contain: collection.collections_courses.count
            }
        end
        courses.each do |course|
            course_list << {
                course: course,
                contain: course.vocabularies.count
            }
        end
        render json: {
            collections: collection_list,
            courses: course_list
        }
    end

    def bookmarked_courses_collections
        user = User.find(params[:user_id])
        bookmark_collections = []
        bookmark_courses = []
        bookmarkCollectionData = user.bookmark_collections
        bookmarkCourseData =  user.bookmark_courses

        bookmarkCollectionData.each do |bookmark|
            bookmark_collections << {
                bookmark: bookmark,
                collection: Collection.find(bookmark[:collection_id])
            }
        end

        bookmarkCourseData.each do |bookmark|
            bookmark_courses << {
                bookmark: bookmark,
                course: Course.find(bookmark[:course_id])
            }
        end
        render json: {
            bookmark_collections: bookmark_collections,
            bookmark_courses: bookmark_courses
        }
    end

    private

    def user_params
        params.require(:user).permit(
            :email,
            :password,
            :password_confirmation,
            :first_name,
            :last_name,
            )
    end
end
