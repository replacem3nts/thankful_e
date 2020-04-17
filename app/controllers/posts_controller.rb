class PostsController < ApplicationController
    before_action :get_post, only: [:show, :create, :edit, :update, :destroy]
    
    # Index primarily driven by navbar which sends query details to 'post<-HTTP verb query' located at bottom of the file then returns them to index in a flash and uses Post.record_builder (see post.rb for more explanation). Navigating straight to index will return today's posts sorted by like count.
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
        @locations = Location.all
        @post.location = user_logged_in.location
        @errors = flash[:errors]
    end
    
    def create
        @user = user_logged_in
        post = @post.create(post_params)
        if post.valid?
            redirect_to @post
        else
            flash[:errors] = post.errors.full_messages
            redirect_to new_post_path
        end
    end
    
    def show
    end
    
    def edit
        @locations = Location.all
        @errors = flash[:errors]
    end

    def update
        @user = user_logged_in
        params[:post][:user_id] = user_logged_in.id
        post = @post.update(post_params)
        if post
            redirect_to @post
        else
            flash[:errors] = post.errors.full_messages
            redirect_to post_edit_path(@path)
        end
    end

    def destroy
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

    def get_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:user_id, :title, :content, :location_id, :category_name)
    end
end

