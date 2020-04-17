class ApplicationController < ActionController::Base
    helper_method :user_logged_in, :logged_in?, :authorize, :last_ten_posts
    
    def user_logged_in
        if session[:user_id]
            @user_logged_in = User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !!user_logged_in
    end

    def authorize
        redirect_to login_path unless logged_in?
    end

end

def last_ten_posts
    @posts = Post.last_ten
end