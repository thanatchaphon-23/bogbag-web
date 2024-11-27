class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post: @post)
    render json: { liked: true, likes_count: @post.likes.count }
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like.destroy if like
    render json: { liked: false, likes_count: @post.likes.count }
  end
end
