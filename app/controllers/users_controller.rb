class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            render json: user, serializer: UserSerializer
        else
            render :json => {
                error: user.errors.full_messages.to_sentence
            }
        end
    end

    def update
        user = User.find_by(id: params[:id])
        if user
            if user == current_user
                if user.update(binder_name: user_params[:binder_name])
                    render json: user, serializer: UserSerializer
                else
                    render :json => {
                        error: user.errors.full_messages.to_sentence
                    }
                end
            else
                render :json => {
                    error: "You are not authorized to edit that"
                }
            end
        else
            render :json => {
                error: "User could not be found"
            }
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :binder_name)
    end
end