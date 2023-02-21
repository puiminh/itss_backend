Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Vu Tuan Kiet
  namespace :api do
    namespace :v1,  defaults: {format: :json}  do

      resource :sessions, only: %i[create destroy] # No plural needed
      resources :users, only: %i[create]

      #user
      get "/users/last_week", to: "users#new_users_last_week", as: "new_users_last_week"
      get "/users/total", to: "users#total", as: "users_total"
      get "/users/created/courses_collections/:user_id", to: "users#created_courses_collections", as: "created_courses_collections"
      get "/users/bookmarked/courses_collections/:user_id", to: "users#bookmarked_courses_collections", as: "bookmarked_courses_collections"

      #course
      get "/courses/recent/:user_id", to: "courses#recent_courses", as: "recent_courses"
      get "/courses/recommended", to: "courses#recommended_courses", as: "recommended_courses"
      get "/courses/last_week", to: "courses#new_courses_last_week", as: "new_courses_last_week"
      get "/courses/total", to: "courses#total", as: "courses_total"
      post "/courses/duplicate/:user_id", to: "courses#duplicate_course", as: "duplicate_course"
      post "/courses/vocabularies", to: "courses#course_with_vocabularies", as: "course_with_vocabularies"
      put "/courses/vocabularies/:course_id", to: "courses#update_course_vocabularies", as: "update_course_vocabularies"

      #collection
      get "/collections/recommended", to: "collections#recommended_collections", as: "recommended_collections"
      get "/collections/last_week", to: "collections#new_collections_last_week", as: "new_collections_last_week"
      get "/collections/total", to: "collections#total", as: "collections_total"
      put "/collections/courses/:collection_id", to: "collections#update_collection_courses", as: "update_collection_courses"
      post "/collections/course", to: "collections_courses#add_course_to_collection", as: "add_course_to_collection"
      post "/collections/courses", to: "collections_courses#collection_with_courses", as: "collection_with_courses"

      #progress
      get "/progress/:course_id/:user_id", to: "progresses#user_progress_course", as: "user_progress_course"
      get "/progress/:user_id", to: "progresses#user_progress", as: "user_progress"
      post "/progress/update", to: "progresses#update_progress", as: "update_progress"

      #courses and collections
      get "/courses_collections/:type/:keyword", to: "collections_courses#keyword_find", as: "keyword_find"

      #comment
      get "/comments/last_week", to: "comments#new_comments_last_week", as: "new_comments_last_week"
      get "/comments/total", to: "comments#total", as: "comments_total"
      get "/comments/course/:course_id", to: "comments#comments_course", as: "comments_course"

      #notice
      get "/notices/user/:user_id", to: "notices#notices_user", as: "notices_user"

      #rating
      get "/ratings/course/:course_id", to: "ratings#course_rating", as: "course_rating"

      #vocabulary
      get "/vocabularies/need/:user_id/:course_id", to: "vocabularies#need_learn", as: "need_learn"

      resources :courses, only: [:index, :show, :create, :update, :destroy]
      resources :collections, only: [:index, :show, :create, :update, :destroy]
      resources :collections_courses, only: [:index, :show, :create, :update, :destroy]
      resources :progresses, only: [:index, :show, :create, :update, :destroy]

      resources :ratings, only: [:index, :show, :create, :update, :destroy]
      resources :vocabularies, only: [:index, :show, :create, :update, :destroy]
      resources :bookmark_collections, only: [:index, :show, :create, :update, :destroy]
      resources :bookmark_courses, only: [:index, :show, :create, :update, :destroy]
      resources :comments, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
