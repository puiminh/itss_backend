Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Vu Tuan Kiet
  get "api/recent_courses/:user_id", to: "courses#recent_courses", as: "recent_courses"
  get "api/recommended_courses", to: "courses#recommended_courses", as: "recommended_courses"
  get "api/recommended_collections", to: "courses#recommended_collections", as: "recommended_collections"
  post "api/duplicate_course/:user_id", to: "courses#duplicate_course", as: "duplicate_course"
  post "api/progress/", to: "courses#progress", as: "progress"
end
