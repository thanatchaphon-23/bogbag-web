class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
    before_action :set_comment, only: [:destroy]
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to root_path, notice: "Comment added successfully."
      else
        redirect_to root_path, alert: "Unable to add comment."
      end
    end

    def destroy
      if @comment.user == current_user
        @comment.destroy
        flash[:notice] = "Comment deleted successfully."
      else
        flash[:alert] = "You are not authorized to delete this comment."
      end
      redirect_to root_path
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_comment
      @comment = @post.comments.find(params[:id])
    end
  end
  