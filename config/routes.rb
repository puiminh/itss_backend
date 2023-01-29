Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Vu Tuan Kiet
  namespace :api do
    resources :courses, only: [:index, :show, :create, :update, :destroy]
    resources :collections, only: [:index, :show, :create, :update, :destroy]
    get "/courses/recent/:user_id", to: "courses#recent_courses", as: "recent_courses"
    get "/courses/recommended", to: "courses#recommended_courses", as: "recommended_courses"
    get "/collections/recommended", to: "collections#recommended_collections", as: "recommended_collections"
    post "/collections/courses", to: "collections_courses#add_course_to_collection", as: "add_course_to_collection"
    post "/courses/duplicate/:user_id", to: "courses#duplicate_course", as: "duplicate_course"
    post "/progress/update", to: "progresses#update_progress", as: "update_progress"
  end
end
