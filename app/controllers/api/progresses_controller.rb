# Vu Tuan Kiet
module Api
    class ProgressesController < ApplicationController
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
    end
end