# Vu Tuan Kiet

class CoursesController < ApplicationController
    def recent_courses
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
    end

    def recommended_courses
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
                author: collection.author,
                bookmark_collections: bookmark_collections_newest.count,
                bookmark_users: users
            }
        end

        recommended_collections = recommended_collections.sort { |a, b| b[:bookmark_collections] <=> a[:bookmark_collections] }
        render json: {
            data: recommended_collections
        }, status: 200
    end

    def duplicate_course
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
    end

    def progress
        user_id = params[:user_id].to_i
        course_id = params[:course_id].to_i
        vocabulary_id = params[:vocabulary_id].to_i
        progress = Progress.find_by(user_id: user_id, course_id: course_id, vocabulary_id: vocabulary_id)
        if !progress 
            progress = Progress.create({
                point: params[:point].to_i,
                user_id: user_id,
                course_id: course_id,
                vocabulary_id: vocabulary_id 
            })
            render json: {
                mess: "New progress created sucess"
            }, status: 200
        else
            progress.point += params[:point].to_i
            if progress.save
                render json: {
                    mess: "Success"
                }, status: 200
            else
                render json: {
                    errors: "Failed to save"
                }, status: 400
            end
        end
    end
end