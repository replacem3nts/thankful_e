class UsersController < ApplicationController
    before_action :authorize, only: [:edit]

    def new
        @user = User.new
        @locations = get_locations
        @errors = flash[:errors]
    end

    def create
        user = User.create(user_params)
        if user.valid?
            redirect_to user_path(user)
        else
            flash[:errors] = user.errors.full_messages
            redirect_to new_user_path
        end
    end

    def show
        @user = get_user
    end

    def edit
        @user = user_logged_in
    end

    def update
    end

    def destroy
    end

    def about
    end

    def posts
        @user = get_user
        @posts = @user.posts
    end

    def liked
        @user = get_user
        @posts = @user.liked_posts
    end

    private

    def get_user
        User.find(params[:id])
    end

    def get_locations
        Location.all
    end

    def user_params
        params.require(:user).permit(:username, :email, :password, :location_id, :phone)
    end
end
