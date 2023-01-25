# Vu Tuan Kiet

class CoursesController < ApplicationController
    def recent_courses
        course_list = []
        progresses = User.find_by(id: params[:user_id]).progresses.group(:course_id).order(updated_at: :desc).limit(8)
        progresses.each do |progress|
            course_list << progress.course
        end

        render json: {
            data: course_list,
        }, status: 200
    end

    def recommended_courses
        recommended_courses = []
        courses = Course.all
        courses.each do |course|
            recommended_courses << {
                course_id: course.id,
                course_title: course.title,
                rating: {
                    sum: course.ratings.sum(:star),
                    avg: course.ratings.average(:star)
                },
                bookmark_courses: course.bookmark_courses.count,
            }
        end
        recommended_courses = recommended_courses.sort { |a, b| [b[:rating][:sum], b[:rating][:avg], b[:bookmark_courses]] <=> [a[:rating][:sum], a[:rating][:avg], a[:bookmark_courses]] }
        render json: {
            data: recommended_courses
        }, status: 200
    end

    def recommended_collections
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
                bookmark_collections: bookmark_collections_newest.count,
                bookmark_user: users
            }
        end

        recommended_collections = recommended_collections.sort { |a, b| b[:bookmark_collections] <=> a[:bookmark_collections] }
        render json: {
            data: recommended_collections
        }, status: 200
    end
end