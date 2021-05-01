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

    def update
        updated = []

        params[:categories].each do |cat|
            id = cat[:id]
            categoryForUpdate = Category.find_by(id: id)
            if categoryForUpdate
                categoryForUpdate.update(position: cat[:position])
                updated << categoryForUpdate
            end
        end

        render json: updated, each_serializer: CategorySerializer
    end
end