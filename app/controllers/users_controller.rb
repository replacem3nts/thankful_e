class UsersController < ApplicationController
    before_action :authorize, only: [:edit, :details, :destroy]
    before_action :get_user, except: [:new, :create]

    def new
        @user = User.new
        @locations = get_locations
        @errors = flash[:errors]
    end

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            redirect_to details_path(user.id)
        else
            flash[:errors] = user.errors.full_messages
            redirect_to new_user_path
        end
    end

    def show
        @calendar = @user.thirty_day_array
    end

    def edit
        @errors = flash[:errors]
    end
    
    def update
        user = @user.update(user_params)
        if user
            URI(request.referer).path == details_path(@user.id) ? (redirect_to user_path(@user)) : (redirect_to details_path(@user))
        else
            flash[:errors] = user.errors.full_messages
            redirect_to edit_user_path(@user)
        end
    end
    
    def destroy
        @user.destroy
        redirect_to root_path
    end
    
    def details
        @locations = get_locations
    end

    def posts
        @posts = @user.posts
    end

    def liked
        @posts = @user.liked_posts
    end

    private

    def get_user
        @user = User.find(params[:id])
    end

    def get_locations
        Location.all
    end

    def user_params
        params.require(:user).permit(:username, :email, :password, :location_id, :phone, :bio, :website, :avatar)
    end
end
