class ReadBlogsController < ApplicationController
  require 'open-uri'

  def index
      @blog_objects = Blog.get_all_blog_objects
      @blog_names = []
      
      @blog_objects.each do |blog_obj|
        @posts = []
        @doc = Nokogiri::XML(open("#{blog_obj.blog_url}"))
        logger.info "===============#{@doc.inspect}"  
        Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NOENT  
        logger.info "=======pp=======#{Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NOENT}"
        # doc = Nokogiri::XML(open("http://mansishahlearnings.blogspot.com/")) do |config|
          # config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NOENT
          # logger.info "0000000000000#{config.options}"
        # end
      
        title_tag = @doc.xpath('//title')
        @blog_names << title_tag.text
        
        post_tags = @doc.xpath('//li')
        post_tags.each do |post|
          @posts << post.text
        end
        
        # write a logic so that each posts related to particular blog can be captured.
      end
      #logger.info "========titles============#{title.inspect}"
  end
  
end