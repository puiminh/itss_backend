class Api::V1::CommentsController < ApplicationController
    def index
        render json: {
            data: Comment.all
        }, status: 200
    end

    def show
        render json: {
            collection: Comment.find(params[:id])
        }, status: 200
    end

    def create
        comment = Comment.new({
            content: params[:content],
            user_id: params[:user_id],
            course_id: params[:course_id]
        })
        if comment.save
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
        comment = Comment.find(params[:id])
        if comment.update(content: params[:content], user_id: params[:user_id], course_id: params[:course_id]) 
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
        comment = Comment.find(params[:id])
        if comment.destroy
            render json: {
                message: "success"
            }, status: 200      
        else
            render json: {
                message: "failure"
            }, status: 400      
        end
    end

    def new_comments_last_week
        render json: Comment.where(
            'created_at >= :last_week',
            :last_week  => Time.now - 7.days
        ), status: :ok
    end

    def total
        render json: {total: Comment.count}, status: :ok
    end
end
