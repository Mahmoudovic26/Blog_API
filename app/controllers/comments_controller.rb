class CommentsController < ApplicationController
    before_action :authorize_request
    before_action :set_post
  
    def create
      @comment = @post.comments.new(comment_params)
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    def show
      @comment = @post.comments.find(params[:id])
      render json: @comment
    end
  
    def update
      @comment = @post.comments.find(params[:id])
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      head :no_content
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end
  end
  