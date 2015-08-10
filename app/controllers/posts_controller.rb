class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :new, :edit, :update, :destroy]
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :owned_post, only: [:edit, :update, :destroy]  

	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 5)
		
	end

	def new
		@post = current_user.posts.build
	end

	def create
	    @post = current_user.posts.build(post_params)

	    if @post.save
	      flash[:success] = "Your post has been created!"
	      redirect_to posts_path
	    else
	      flash[:warning] = "Your new post couldn't be created!  Please check the form."
	      render :new
	    end
	  end

	def show
	end

	def edit
	end

	def update
		if @post.update(post_params)
			flash[:success] = "Post edited!"
			redirect_to posts_path
		else
			flash.now[:warning] = "Update failed!"
			render :edit
		end
	end

	def destroy
		@post.destroy
		flash[:danger] = "Post Deleted!"
		redirect_to posts_path
	end



		private

		def post_params
			params.require(:post).permit(:image, :caption)
		end

		def set_post
			@post = Post.find(params[:id])
		end


	    def owned_post  
		  unless current_user == @post.user
		    flash[:warning] = "That post doesn't belong to you!"
		    redirect_to root_path
		  end
		end 


end
