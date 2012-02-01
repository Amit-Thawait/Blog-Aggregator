class ReadBlogsController < ApplicationController
  	
  def index
    @blogs = Blog.get_blog_objects
    @blog_objects = Blog.read_blogs(@blogs)
    @posts = Post.all.sort
  end  
  
end
