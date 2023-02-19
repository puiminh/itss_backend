# Vu Tuan Kiet
class Api::V1::CoursesController < ApplicationController
    def index
        render json: {
            data: Course.all
        }, status: 200
    end

    def show
        course = Course.find(params[:id])
        vocabularies = course.vocabularies
        render json: {
            course: course,
            vocabularies: vocabularies
        }, status: 200
    end

    def create
        course = Course.new({
            title: params[:title],
            desc: params[:desc],
            author: params[:author],
        })
        if course.save
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
        course = Course.find(params[:id])
        if course.update(title: params[:title], desc: params[:desc]) 
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
        course = Course.find(params[:id])
        if course.destroy
            render json: {
                message: "success"
            }, status: 200      
        else
            render json: {
                message: "failure"
            }, status: 400      
        end
    end

    def recent_courses
        begin
            course_list = []
            progresses = User.find_by(id: params[:user_id]).progresses.group(:course_id).order(updated_at: :desc).limit(8)
            progresses.each do |progress|
                course_list << {
                    course: progress.course,
                    progress: progress
                }
            end

            render json: {
                data: course_list,
            }, status: 200
        rescue
            render json: {
                errors: "Something went wrong"
            }, status: 500
        end
    end

    def recommended_courses
        begin
            recommended_courses = []
            courses = Course.all
            courses.each do |course|
                recommended_courses << {
                    course: course,
                    author: course.author,
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
        rescue
            render json: {
                errors: "Something went wrong"
            }, status: 500
        end
    end

    def duplicate_course
        begin
            user_id = params[:user_id].to_i
            course_id = params[:course_id].to_i
            course = Course.find(course_id)
            vocabularies = course.vocabularies
            new_course = Course.create({
                title: course.title+"_copy",
                desc: course.desc,
                author_id: user_id,
            })
            vocabularies.map do |vocab|
                new_course.vocabularies.create({
                    word: vocab.word,
                    define: vocab.define,
                    link: vocab.link,
                    kind: vocab.kind,
                    course_id: new_course.id
                })
            end

            render json: {
                course: new_course,
            }, status: 200
        rescue
            render json: {
                errors: "Something went wrong"
            }, status: 500
        end
    end
end