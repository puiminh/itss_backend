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
        render json: {
            data: recommended_courses
        }, status: 200
    end
end