class Api::V1::CollectionsController < ApplicationController
    def index
        render json: {
            data: Collection.all
        }, status: 200
    end

    def show
        collection = Collection.find(params[:id])
        collections_courses = collection.collections_courses
        courses = collections_courses.map do |collection_course|
            collection_course.course
        end
        courses = courses.map do |course|
            {
                course: course,
                total_vocabularies: course.vocabularies.count,
            }
        end
        render json: {
            collection: collection,
            contain: collections_courses.count,
            courses: courses,
            author: collection.author
        }, status: 200
    end

    def create
        collection = Collection.new({
            title: params[:title],
            desc: params[:desc],
            image: params[:image],
            author_id: params[:author_id],
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

    def created_collections
        user = User.find(params[:user_id])
        collections = user.collections
        render json: {
            data: collections
        }
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
                    contain: collection.collections_courses.count,
                    author: collection.author,
                    bookmark_collections: bookmark_collections_newest.count,
                    bookmark_users: users
                }
            end

            recommended_collections = recommended_collections.sort { |a, b| b[:bookmark_collections] <=> a[:bookmark_collections] }
            render json: {
                data: recommended_collections.slice(0,4)
            }, status: 200
        rescue
            render json: {
                errors: "Something went wrong"
            }, status: 500
        end
    end

    def new_collections_last_week
        render json: Collection.where(
            'created_at >= :last_week',
            :last_week  => Time.now - 7.days
        ), status: :ok
    end

    def total
        render json: {total: Collection.count}, status: 200
    end

    def update_collection_courses
        collection_id = params[:collection_id]
        collection_data = params[:collection]
        courses_id = params[:courses]
        collection = Collection.find(collection_id)
        collection.update(title: collection_data['title'], desc: collection_data['desc'], image: collection_data['image'])
        CollectionsCourse.where("collection_id = ?", collection_id).destroy_all
        courses_id.each do |course_id|
            CollectionsCourse.create(collection_id: collection_id, course_id: course_id)
        end
        render json: {message: "Collection and courses updated"}, status: 200
    end
end
