class ReadBlogsController < ApplicationController
  def index    
      @blogs = Blog.read_blogs
  end  
end