class PostsController < ApplicationController
    def index
        @posts = Post.sort_likes
    end

    def new
        @post = Post.new
        @users = User.all
        @locations = Location.all
        @post.categories.build(name: 'Category 1')
        @post.categories.build(name: 'Category 2')
        @post.categories.build(name: 'Category 3')
    end

    def create
        @post = Post.create(post_params)
        redirect_to @post
        byebug
    end

    def show
        @post = get_post
    end

    def edit
        @post = get_post
        @users = User.all
        @locations = Location.all
    end

    def update
        @post.update(post_params)
        redirect_to @post
    end

    def destroy
        @post = get_post
        @post.destroy
        redirect_to posts_path
    end

    private

    def get_post
        Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:user_id, :title, :content, :location_id, categories_attributes: [])
    end

end

