class ReadBlogsController < ApplicationController
  require 'open-uri'

  def index
      @blog_objects = Blog.get_all_blog_objects
      @blog_names = []
      @posts = []
      @content = []
      @author_name = []
      
      @blog_objects.each do |blog_obj|
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
        
        post_tags = @doc.xpath('//h3/a')
        post_tags.each do |post|
          @posts << post.
        end

        
        # this can be used to capture time
        doc.xpath('//abbr').each do |time|
          puts "=====#{time['title'].class}"
        end
        
        #"2012-01-04T06:40:00-08:00".to_s > "2012-01-04T06:39:00-08:00".to_s
        
        # post_tags = @doc.css('h3>a')
        # post_tags.each do |post|
          # @posts << post
        # end
        
        @doc.xpath('//div[@dir = "ltr"]').each do |content|
          @content << content.text  
        end
        
        @author_name = @doc.xpath('//a[@class = "profile-name-link"]').text.strip
        
        # write a logic so that each posts related to particular blog can be captured.
      end
      #logger.info "========titles============#{title.inspect}"
  end
  
end