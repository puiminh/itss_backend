class Api::V1::BookmarkCollectionsController < ApplicationController
    def index
        render json: {
            data: BookmarkCollection.all
        }, status: 200
    end

    def show
        render json: {
            data: BookmarkCollection.find(params[:id])
        }, status: 200
    end

    def create
        bookmark_collection = BookmarkCollection.new({
            user_id: params[:user_id],
            collection_id: params[:collection_id]
        })
        if bookmark_collection.save
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
        bookmark_collection = BookmarkCollection.find(params[:id])
        if bookmark_collection.update(user_id: params[:user_id], collection_id: params[:collection_id]) 
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
        bookmark_collection = BookmarkCollection.find(params[:id])
        if bookmark_collection.destroy
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
