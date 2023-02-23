class Api::V1::RatingsController < ApplicationController
    def index
        render json: {
            data: Rating.all
        }, status: 200
    end

    def show
        render json: {
            data: Rating.find(params[:id])
        }, status: 200
    end

    #Ho tro update khi da trung
    def create
        star = params[:star];
        user_id = params[:user_id];
        course_id = params[:course_id];

        rated = Rating.find_by(["user_id = ? and course_id = ?", user_id, course_id])
        if rated
            if rated.update(star: star, user_id: user_id, course_id: course_id) 
                render json: {
                    message: "success"
                }, status: 200
            else
                render json: {
                    message: "error"
                }, status: 400
            end
        else
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

    def course_rating
        course = Course.find(params[:course_id])
        render json: {
            total_ratings: course.ratings.count(:star),
            average_ratings: course.ratings.average(:star)
        }
    end
end
