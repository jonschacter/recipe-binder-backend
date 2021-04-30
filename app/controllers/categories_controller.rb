class CategoriesController < ApplicationController
    def index
        if logged_in?
            categories = current_user.categories
            render json: categories, each_serializer: CategorySerializer
        else
            render :json => {
                error: "You need to log in to view this"
            }
        end
    end
end