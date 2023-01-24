Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Vu Tuan Kiet
  get "api/recent_courses/:user_id", to: "courses#recent_courses", as: "recent_courses"
  get "api/recommended_courses", to: "courses#recommended_courses", as: "recommended_courses"
end
