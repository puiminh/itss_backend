class Api::V1::BookmarkCoursesController < ApplicationController
    def index
        render json: {
            data: BookmarkCourse.all
        }, status: 200
    end

    def show
        render json: {
            data: BookmarkCourse.find(params[:id])
        }, status: 200
    end

    # Support bookmark and remove bookmark
    def create
        user_id = params[:user_id]
        course_id = params[:course_id]
        bookmark_course = BookmarkCourse.find_by(["user_id = ? and course_id = ?", user_id, course_id])
        if (bookmark_course)
            if bookmark_course.destroy
                render json: {
                    message: "delete successfully"
                }, status: 200      
            else
                render json: {
                    message: "failure"
                }, status: 400      
            end     
        else
            bookmark_course = BookmarkCourse.new({
                user_id: params[:user_id],
                course_id: params[:course_id]
            })
    
            if bookmark_course.save
                notify_create
                render json: {
                    bookmark: bookmark_course,
                    message: "create successfully"
                }, status: 201
            else
                render json: {
                    message: "error"
                }, status: 400
            end
        end

    end

    def update
        bookmark_course = BookmarkCourse.find(params[:id])
        if bookmark_course.update(user_id: params[:user_id], course_id: params[:course_id]) 
            render json: {
                message: "success"
            }, status: 200
        else
            render json: {
                error: bookmark_course.errors
            }, status: 400
        end
    end

    def destroy
        bookmark_course = BookmarkCourse.find(params[:id])
        if bookmark_course.destroy
            render json: {
                message: "success"
            }, status: 200      
        else
            render json: {
                message: "failure"
            }, status: 400      
        end
    end

    private
    
    def notify_create
        user = User.find(params[:user_id])
        course = Course.find(params[:course_id])
        msg = " has bookmarked your course \'#{course.title}\'"
        save_notice(course.author.id, user.id, msg)
    end
end
