class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] # บังคับล็อกอิน
    before_action :set_post, only: [:edit, :update, :destroy] # โหลดโพสต์ก่อนแก้ไขหรือลบ
    before_action :authorize_user!, only: [:edit, :update, :destroy] # ตรวจสอบสิทธิ์ผู้ใช้
  
    def index
      if params[:query].present?
        @posts = Post.where("title LIKE :query OR content LIKE :query", query: "%#{params[:query]}%")
      else
        @posts = Post.all
      end
    end
  
    def new
      @post = Post.new
    end

    def create
        @post = current_user.posts.build(post_params) # เชื่อมโพสต์กับผู้ใช้ล็อกอิน
        if @post.save
          redirect_to root_path, notice: "Post created successfully!"
        else
          render :new, status: :unprocessable_entity
        end
    end
  

    def edit
    end
  
    def update
      if @post.update(post_params)
        redirect_to root_path, notice: "Post updated successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
        @post = Post.find(params[:id]) # ค้นหาโพสต์ตาม ID
        if @post.user == current_user # ตรวจสอบว่าเป็นโพสต์ของผู้ใช้ปัจจุบัน
          @post.destroy
          redirect_to root_path, notice: "Post deleted successfully!"
        else
          redirect_to root_path, alert: "You are not authorized to delete this post."
        end
    end
      
  
    private

    def set_post
        @post = Post.find(params[:id])
    end

    def authorize_user!
        redirect_to root_path, alert: "You are not authorized to perform this action." unless @post.user == current_user
    end
  
    def post_params
      params.require(:post).permit(:title, :content) # อนุญาตเฉพาะ title และ content
    end
end
  