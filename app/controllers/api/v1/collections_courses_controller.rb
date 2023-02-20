class Api::V1::CollectionsCoursesController < ApplicationController
    def index
        render json: {
            data: CollectionsCourse.all
        }, status: 200
    end

    def show
        render json: {
            collection: CollectionsCourse.find(params[:id])
        }, status: 200
    end

    def create
        collections_course = CollectionsCourse.new({
            collection_id: params[:collection_id],
            course_id: params[:course_id],
        })
        if collections_course.save
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
        collections_course = CollectionsCourse.find(params[:id])
        if collections_course.update(collection_id: params[:collection_id], course_id: params[:course_id]) 
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
        collections_course = CollectionsCourse.find(params[:id])
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

    def add_course_to_collection
        course = Course.find(params[:course_id])
        collection = Collection.find(params[:collection_id])
        if course.author_id == collection.author_id
            collection_course = CollectionsCourse.new(course_id: course.id, collection_id: collection.id)
            if collection_course.save
                render json: collection_course, status: :created
            else 
                render json: collection_course.errors, status: :unprocessable_entity
            end
        else
            render json: {
                errors: "You are not the author of this collection"
            }, status: :unprocessable
        end
    end

    def keyword_find
        type = params[:type]
        keyword = params[:keyword]
        if type == "course"
            data = Course.where("`title` LIKE :title OR `desc` LIKE :desc", :title => "%#{keyword}%", :desc => "#{keyword}").limit(6)
            render json: {data: data}, status: :ok
        elsif type == "collection"
            data = Collection.where("`title` LIKE :title OR `desc` LIKE :desc", :title => "%#{keyword}%", :desc => "#{keyword}").limit(6)
            render json: {data: data}, status: :ok
        else
            render json: {
                message: "Invalid type"
            }, status: :unprocessable_entity
        end
    end

    def collection_with_courses
        collection_data = params[:collection]
        collection = Collection.create(title: collection_data["title"], desc: collection_data["desc"], author_id: collection_data["author_id"])
        courses_id = params[:courses]
        courses_id.map do |course_id|
            CollectionsCourse.create(collection_id: collection.id, course_id: course_id)
        end
        render json: {data: collection}, status: :ok
    end
end
