class Api::V1::CollectionsCoursesController < ApplicationController
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
end
