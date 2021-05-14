Rails.application.routes.draw do
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/current_user", to: "sessions#show"
    post "/signup", to: "users#create"
    patch "/categories/reorder", to: "categories#update"

    resources :users, only: [:update]
    resources :categories, only: [:index, :destroy]
end
