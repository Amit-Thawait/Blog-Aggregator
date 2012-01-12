class ReadBlogsController < ApplicationController
  require 'will_paginate'
  def index  
      params[:page]||= 1
      params[:per_page] = 3  
      @blogs = Blog.paginate(:page => params[:page], :per_page => 3)
      @blog_objects = Blog.read_blogs(:blogs => @blogs)
  end  
end