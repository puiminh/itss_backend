class Api::V1::RatingsController < ApplicationController
    def index
        render json: {
            data: Rating.all
        }, status: 200
    end

    def show
        render json: {
            collection: Rating.find(params[:id])
        }, status: 200
    end

    def create
        rating = Rating.new({
            star: params[:star],
            user_id: params[:user_id],
            course_id: params[:course_id]
        })
        if rating.save
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
        rating = Rating.find(params[:id])
        if rating.update(star: params[:star], user_id: params[:user_id], course_id: params[:course_id]) 
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
        rating = Rating.find(params[:id])
        if collections_course.destroy
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
