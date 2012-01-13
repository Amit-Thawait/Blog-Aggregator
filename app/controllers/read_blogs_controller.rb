class ReadBlogsController < ApplicationController 
  def index
      @blog_objects = Blog.read_blogs   
  end  
end