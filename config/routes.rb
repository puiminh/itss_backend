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

      #course
      get "/courses/recent/:user_id", to: "courses#recent_courses", as: "recent_courses"
      get "/courses/recommended", to: "courses#recommended_courses", as: "recommended_courses"
      get "/courses/last_week", to: "courses#new_courses_last_week", as: "new_courses_last_week"
      get "/courses/total", to: "courses#total", as: "courses_total"
      post "/courses/duplicate/:user_id", to: "courses#duplicate_course", as: "duplicate_course"
      post "/courses/vocabularies", to: "courses#course_with_vocabularies", as: "course_with_vocabularies"

      #collection
      get "/collections/recommended", to: "collections#recommended_collections", as: "recommended_collections"
      get "/collections/last_week", to: "collections#new_collections_last_week", as: "new_collections_last_week"
      get "/collections/total", to: "collections#total", as: "collections_total"
      post "/collections/course", to: "collections_courses#add_course_to_collection", as: "add_course_to_collection"
      post "/collections/courses", to: "collections_courses#collection_with_courses", as: "collection_with_courses"

      post "/progress/update", to: "progresses#update_progress", as: "update_progress"

      #courses and collections
      get "/courses_collections/:type/:keyword", to: "collections_courses#keyword_find", as: "keyword_find"

      #comment
      get "/comments/last_week", to: "comments#new_comments_last_week", as: "new_comments_last_week"
      get "/comments/total", to: "comments#total", as: "comments_total"

      #notice
      get "/notices/user/:user_id", to: "notices#notices_user", as: "notices_user"

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
