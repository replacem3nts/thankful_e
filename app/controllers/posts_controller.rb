class PostsController < ApplicationController
    helper_method :liked?, :post_like

    # Index primarily driven by navbar which sends query details to 'post query' then returns them to index in a flash and uses Post.record_builder. Navigating straight to index will return today's posts sorted by like count.
    def index
        @params = flash[:query] ||= {}
        case @params.length
        when 0
            @header = "All Thanks" 
            @posts = Post.record_builder()
        when 1
            @finder = @params.keys.first
            @value = @params.values.first
            @finder_name = get_name(@finder, @value)
            @posts = Post.record_builder(@finder, @value)
        when 2
            @finder = @params.keys.first
            @value = @params.values.first
            @sorter = @params.keys.second
            @finder_name = get_name(@finder, @value)
            @posts = Post.record_builder(@finder, @value, @sorter)
        end
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

    def query
        flash[:query] = params[:query]
        redirect_to posts_path
    end

    private

    def get_name(finder, value)
        if finder == "Location"
            "in #{finder.constantize.find(value).state}"
        elsif finder == "Category"
            " in #{finder.constantize.find(value).name}"
        else
            "since #{value.to_datetime.strftime("%B %d, %Y")}"
        end
    end

    def get_user
        User.find(params[:id])
    end

    def get_post
        Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:user_id, :title, :content, :location_id, categories_attributes: [])
    end

end

