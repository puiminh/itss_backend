class Api::V1::CoursesController < ApplicationController
    # before_action :authenticate_user!
    def all_course
        all_course = Course.all
        course_list = []
        all_course.each do |course|
                author = course.author
                course_list << {
                    course: course,
                    contain: course.vocabularies.count,
                    author: author
                }
        end    
        render json: {
            data: course_list,
        }, status: 200
    end

    def index
        render json: {
            data: Course.all
        }, status: 200
    end

    def show
        course = Course.find(params[:id])
        author = User.find(course.author_id)
        vocabularies = course.vocabularies
        render json: {
            course: course,
            vocabularies: vocabularies,
            author: author,
        }, status: 200
    end

    def create
        course = Course.new({
            title: params[:title],
            desc: params[:desc],
            author_id: params[:author_id],
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
        @deleted_course = Course.find(params[:course_id])
        if @deleted_course.destroy
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

    def created_courses
        user = User.find(params[:user_id])
        courses = user.courses
        course_list = []
        courses.each do |course|
                author = course.author
                course_list << {
                    course: course,
                    contain: course.vocabularies.count,
                    author: author
                }
        end    
        render json: {
            data: course_list,
        }, status: 200
    end

    def recent_courses
        begin
            course_list = []
            progresses = Progress.select(:course_id, "max(updated_at) as maxupdate").where(user_id: params[:user_id]).group(:course_id).order(maxupdate: :desc).limit(6)
            progresses.each do |progress|
                course = progress.course
                author = course.author
                course_list << {
                    course: course,
                    contain: course.vocabularies.count,
                    author: author,
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
                    contain: course.vocabularies.count,
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
                data: recommended_courses.slice(0, 6)
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
            notify_duplicate_course
            render json: {
                course: new_course,
            }, status: 200
        rescue
            render json: {
                errors: "Something went wrong"
            }, status: 500
        end
    end

    def course_with_vocabularies
        course_data = params["course"]
        vocabularies = params["vocabs"]

        course = Course.create(title: course_data["title"], desc: course_data["desc"], author_id: course_data["author_id"])
        vocabs = vocabularies.map do |vocab|
            Vocabulary.create(word: vocab["word"], define: vocab["define"], link: vocab["link"], kind: vocab["kind"], course_id: course.id)
        end
        render json: {
            course: course,
            vocabularies: vocabs
        }, status: 200
    end

    def new_courses_last_week
        render json: Course.where(
            'created_at >= :last_week',
            :last_week  => Time.now - 7.days
        ), status: :ok
    end

    def total
        render json: {total: Course.count}, status: 200
    end

    def update_course_vocabularies
        course_id = params["course_id"]
        course_data = params["course"]
        new_vocabularies = params["vocabs"]
        course = Course.find(course_id)
        course.update(title: course_data["title"], desc: course_data["desc"])
        old_vocabularies = course.vocabularies
        old_vocabularies.each do |old_vocab|
            old_vocab.destroy
        end
        new_vocabularies.each do |new_vocab|
            Vocabulary.create(word: new_vocab["word"], define: new_vocab["define"], link: new_vocab["link"], kind: new_vocab["kind"], course_id: course.id)
        end
        render json: {
            message: "Course and vocabularies updated"
        }, status: 200
    end

    def random_list_word
        course_id = params["course_id"]
        course = Course.find(course_id)
        vocabularies = course.vocabularies.order("RAND()").limit(10)
        render json: {
            vocabularies: vocabularies
        }
    end


    private

    def notify_duplicate_course
        by_user = User.find(params[:user_id])
        course = Course.find(params[:course_id])
        msg = " has duplicated your course \'#{course.title}\'"
        save_notice(course.author.id,by_user.id, msg)
    end

    def notify_delete
        by_user =  User.find(params[:by_user_id])
        msg = " has deleted your course \'#{@deleted_course.title}\'"
        save_notice(@deleted_course.author.id, by_user.id, msg)
    end

end
