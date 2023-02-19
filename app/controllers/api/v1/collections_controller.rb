class Api::V1::CollectionsController < ApplicationController
    def index
        render json: {
            data: Collection.all
        }, status: 200
    end

    def show
        render json: {
            collection: Collection.find(params[:id])
        }, status: 200
    end

    def create
        collection = Collection.new({
            title: params[:title],
            desc: params[:desc],
            image: params[:image],
            author: params[:author],
        })
        if collection.save
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
        collection = Collection.find(params[:id])
        if collection.update(title: params[:title], desc: params[:desc], image: params[:image]) 
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
        collection = Collection.find(params[:id])
        if collection.destroy
            render json: {
                message: "success"
            }, status: 200      
        else
            render json: {
                message: "failure"
            }, status: 400      
        end
    end

    def recommended_collections
        begin
            recommended_collections = []
            collections = Collection.all
            collections.each do |collection|
                bookmark_collections = collection.bookmark_collections
                newest_date = bookmark_collections.maximum(:updated_at)
                newest_date = newest_date ? newest_date.to_date : nil
                bookmark_collections_newest = bookmark_collections.where('DATE(updated_at)=?', newest_date)

                users = bookmark_collections_newest.map do |bookmark_collection|
                    bookmark_collection.user
                end

                recommended_collections << {
                    collection: collection,
                    author: collection.author,
                    bookmark_collections: bookmark_collections_newest.count,
                    bookmark_users: users
                }
            end

            recommended_collections = recommended_collections.sort { |a, b| b[:bookmark_collections] <=> a[:bookmark_collections] }
            render json: {
                data: recommended_collections
            }, status: 200
        rescue
            render json: {
                errors: "Something went wrong"
            }, status: 500
        end
    end
end
