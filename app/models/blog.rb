class Blog < ActiveRecord::Base
  require 'open-uri'
  validates_presence_of :blogger_name
  validates_presence_of :blog_url
  
  def self.get_all_blog_objects
    Blog.find(:all)
  end
  
  def self.read_blogs
    blog_objects = get_all_blog_objects    
      
      logger.info "==========blog_objects============#{blog_objects.inspect}"
      @blogs = Hash.new

      
      blog_objects.each do |blog_obj|
        post = Hash.new
        post_content = Hash.new
        doc = Nokogiri::XML(open("#{blog_obj.blog_url}"))
        Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NOENT  
      
        blog_title = doc.xpath('//title').text
        
        doc.css('div.date-outer').each do |post_data|
          post_timestamp = post_data.css('abbr').attr('title').value
          post_title = post_data.css('h3 a').text
          post_url = post_data.css('h3 a').attr('href').text
          content = post_data.css('div[@dir = "ltr"]').text
          post_date = post_data.css('h2.date-header').text
          post_author = post_data.css('span.fn').text.strip
          
          post_content[:post_title] = post_title
          post_content[:post_url] = post_url
          post_content[:content] = content
          post_content[:post_date] = post_date
          post_content[:post_author] = post_author
          post[post_timestamp] = post_content
        end


        
        
        @blogs[blog_title] = post
        logger.info "====post_content==========#{post_content.inspect}"
        logger.info "====post==========#{post.inspect}"
        logger.info "====@blogs==========#{@blogs.inspect}"
      end
      @blogs  
        # this can be used to capture time
        # doc.xpath('//abbr').each do |time|
          # puts "=====#{time['title'].class}"
        # end
        
        #"2012-01-04T06:40:00-08:00".to_s > "2012-01-04T06:39:00-08:00".to_s
        
        # post_tags = @doc.css('h3>a')
        # post_tags.each do |post|
          # @posts << post
        # end
        
        # @doc.xpath('//div[@dir = "ltr"]').each do |content|
          # @content << content.text  
        # end
        
        #@author_name = @doc.xpath('//a[@class = "profile-name-link"]').text.strip
        
        # write a logic so that each posts related to particular blog can be captured.
  end
  
end
