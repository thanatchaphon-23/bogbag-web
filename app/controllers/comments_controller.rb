class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]
  
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
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  