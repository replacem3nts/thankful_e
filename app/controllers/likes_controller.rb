class LikesController < ApplicationController

    def create
        user_logged_in.likes.create(like_params)
        redirect_back(fallback_location: posts_path)
    end

    def destroy
        user_logged_in.liked_posts.delete(Post.find_by(unlike_params))
        redirect_back(fallback_location: posts_path)
    end

    private

    def like_params
        params.require(:like).permit(:post_id)
    end

    def unlike_params
        params.require(:like).permit(:id)
    end
end
