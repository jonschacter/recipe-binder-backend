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

    def destroy
        category = Category.find_by(id: params[:id])
        if category
            if category.user == current_user
                category.destroy
                render :json => {
                    notice: "Review successfully delete"
                }
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