class Api::V1::CommentsController < ApplicationController
    
    def all_comment
        all_comment = Comment.all
        comment_list = []
        all_comment.each do |comment|
                author = comment.user
                course = comment.course
                comment_list << {
                    comment: comment,
                    course: course,
                    author: author
                }
        end    
        render json: {
            data: comment_list,
        }, status: 200
    end

    def index
        render json: {
            data: Comment.all
        }, status: 200
    end

    def show
        render json: {
            data: Comment.find(params[:id])
        }, status: 200
    end

    def create
        @comment = Comment.new({
            content: params[:content],
            user_id: params[:user_id],
            course_id: params[:course_id]
        })
        if @comment.save
            notify_save
            render json: {
                message: "success"
            }, status: 201
        else
            render json: {
                message: @comment.errors
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
                error: comment.errors
            }, status: 400
        end
    end

    def destroy
        @deleted_comment = Comment.find(params[:comment_id])
        if @deleted_comment.destroy
            notify_delete
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

    def comments_course
        course = Course.find(params[:course_id])
        data = []
        comments = course.comments
        comments.each do |comment|
            data << {
                comment: comment,
                user: comment.user
            }
        end
        render json: {
            comments: data,
            total: comments.count
        }, status: 200
    end

    private

    def notify_save
        msg = "commented on your course \'#{@comment.course.title}\'"
        save_notice(@comment.course.author.id, @comment.user_id, msg)
    end

    def notify_delete
        msg = "has deleted your comment \'#{@deleted_comment.content}\'"
        save_notice(@deleted_comment.user.id, params[:by_user_id],msg)
    end
end
