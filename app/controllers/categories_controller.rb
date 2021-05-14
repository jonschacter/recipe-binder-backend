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
        updated_categories = []

        params[:categories].each do |cat|
            id = cat[:id]
            category_for_update = Category.find_by(id: id)
            if category_for_update
                category_for_update.update(position: cat[:position])
                updated_categories << category_for_update
            end
        end

        render json: updated_categories, each_serializer: CategorySerializer
    end

    def destroy
        category = Category.find_by(id: params[:id])
        categories = current_user.categories.order(:position)
        updated_categories = []
        if category
            if category.user == current_user
                i = category.position
                while i < categories.length do
                    categories[i].update(position: i)
                    updated_categories << categories[i]
                    i += 1
                end
                category.destroy
                render json: updated_categories, each_serializer: CategorySerializer, notice: "Succesfully deleted"
            else
                render :json => {
                    error: "You are not authorized to delete this review"
                }
            end
        else
            render :json => {
                error: "Category could not be found"
            }
        end
    end
end