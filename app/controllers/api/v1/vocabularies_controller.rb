class Api::V1::VocabulariesController < ApplicationController
    def index
        render json: {
            data: Vocabulary.all
        }, status: 200
    end

    def show
        render json: {
            data: Vocabulary.find(params[:id])
        }, status: 200
    end

    def create
        vocabulary = Vocabulary.new({
            course_id: params[:course_id],
            word: params[:word],
            define: params[:define],
            link: params[:link],
            kind: params[:kind]
        })
        if vocabulary.save
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
        vocabulary = Vocabulary.find(params[:id])
        if vocabulary.update(course_id: params[:course_id], word: params[:word], define: params[:define], link: params[:link], kind: params[:kind]) 
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
        vocabulary = Vocabulary.find(params[:id])
        if vocabulary.destroy
            render json: {
                message: "success"
            }, status: 200      
        else
            render json: {
                message: "failure"
            }, status: 400      
        end
    end

    def need_learn
        progresses = Progress.where(user_id: params[:user_id], course_id: params[:course_id]).order(point: :asc).limit(10)
        data = progresses.map do |progress|
            progress.vocabulary
        end
        render json: data, status: :ok
    end
end
