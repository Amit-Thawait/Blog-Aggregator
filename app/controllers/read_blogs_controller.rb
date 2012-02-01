class ReadBlogsController < ApplicationController
  	
  def index
    @blogs = Blog.all
    @posts = Post.order("post_date DESC").page(params[:page])
  end  
  
end
