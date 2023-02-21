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

    def create
        bookmark_course = BookmarkCourse.new({
            user_id: params[:user_id],
            course_id: params[:course_id]
        })
        if bookmark_course.save
            render json: {
                message: "success"
            }, status: 201
        else
            render json: {
                message: "error"
            }, status: 400
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
                message: "error"
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
end
