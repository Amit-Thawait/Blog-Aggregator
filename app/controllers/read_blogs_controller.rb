class ReadBlogsController < ApplicationController
  require 'open-uri'

  def index 
      @blog_objects = Blog.read_blogs
  end
  
end