# Vu Tuan Kiet
class Api::V1::ProgressesController < ApplicationController
    def index
        render json: {
            data: Progress.all
        }, status: 200
    end

    def show
        render json: {
            data: Progress.find(params[:id])
        }, status: 200
    end

    def create
        progress = Progress.new({
            point: params[:point],
            user_id: params[:user_id],
            course_id: params[:course_id],
            vocabulary_id: params[:vocabulary_id],
        })
        if progress.save
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
        progress = Progress.find(params[:id])
        if progress.update( point: params[:point], user_id: params[:user_id], course_id: params[:course_id], vocabulary_id: params[:vocabulary_id] ) 
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
        progress = Progress.find(params[:id])
        if progress.destroy
            render json: {
                message: "success"
            }, status: 200      
        else
            render json: {
                message: "failure"
            }, status: 400      
        end
    end

    def update_progress
        begin
            user_id = params[:user_id].to_i
            course_id = params[:course_id].to_i
            vocabulary_id = params[:vocabulary_id].to_i
            progress = Progress.find_by(user_id: user_id, course_id: course_id, vocabulary_id: vocabulary_id)
            if !progress 
                progress = Progress.create({
                    point: params[:point].to_i,
                    user_id: user_id,
                    course_id: course_id,
                    vocabulary_id: vocabulary_id 
                })
                render json: {
                    mess: "New progress created sucess"
                }, status: 200
            else
                progress.point += params[:point].to_i
                if progress.save
                    render json: {
                        mess: "Success"
                    }, status: 200
                else
                    render json: {
                        errors: "Failed to save"
                    }, status: 400
                end
            end
        rescue
            render json: {
                errors: "Something went wrong"
            }, status: 500
        end
    end

    def user_progress_course
        course_id = params[:course_id]
        user_id = params[:user_id]
        progresses = Progress.find_by(user_id: user_id, course_id: course_id)
        count = Course.find(course_id).vocabularies.count
        count = 0 ? 1 : count
        render json: {
            progresses: (progresses.point/count)*10,
        }, status: 200
    end

    def user_progress
        user_id = params[:user_id]
        progresses = Progress.where("user_id = ?", user_id)
        data = []
        progresses.each do |progress|
            count = progress.course.vocabularies.count
            count = count == 0 ? 1 : count
            data << {
                course_id: progress.course_id,
                progress: (progress.point/count)*10,
            }
        end
        render json: data, status: 200
    end
end
