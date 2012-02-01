class Blog < ActiveRecord::Base
  require 'open-uri'
  validates_presence_of :blogger_name
  validates_presence_of :blog_url
  validates_format_of :blog_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  def self.get_blog_objects
    Blog.all
  end
  
  # Method to read blogs and their posts
  #def self.read_blogs(options)
    #blogs = Blog.all 
    #@blogs_hash = Hash.new  
   #options[:blogs].each do |blog|        
      #@doc = Nokogiri::HTML(open("#{blog.blog_url}"))     
      #if @doc!= nil
        #@doc.css('div.post').each do |node|       
         # post_details = Hash.new
          #title_url = node.css('h3.post-title a')
         # post_details[:post_title] = {:title => node.css('h3.post-title').text,:url => title_url[0]['href'] }  
          #post_details[:post_content] = node.css('div.post-body').inner_html.chomp
         # post_details[:author] = node.css('span.fn').text  
         # post_details[:blog_title] = @doc.css('h1.title').text
         # published_date = node.css('abbr.published') 
         # post_date = Time.parse(published_date[0]['title'].gsub('T'," "))    
         # post_details[:post_date] = post_date.strftime('%A ,%d %B %Y')          
         # @blogs_hash[published_date[0]['title'].gsub('T'," ")] = post_details 
        #end 
     #end
     #end
     #return @blogs_hash.sort.reverse
  #end
  
  def self.read_blogs(blogs)
    @posts=[]
    blogs.each do |blog|
      puts"@@@@@url@@@#{blog.blog_url}"
      @doc = Nokogiri::HTML(open("#{blog.blog_url}"))
      if !@doc.nil?
        puts"@@@@@@@@COME@@@@#{@doc}"
        @doc.css('div.post').each do |node|
          puts"@@@@super@@"
          @post = Post.new
          puts"@@@@NEW@@@#{@post}"
          title_url = node.css('h3.post-title a')
          @post.title = {:title => node.css('h3.post-title').text,:url => title_url[0]['href'] }  
          @post.content = node.css('div.post-body').inner_html.chomp
          @post.author = node.css('span.fn').text  
          #@post.blog_title = @doc.css('h1.title').text
          published_date = node.css('abbr.published') 
          post_date = Time.parse(published_date[0]['title'].gsub('T'," "))    
          @post.post_date = post_date.strftime('%A ,%d %B %Y') 
          @post.save!         
        end
         @posts << @post    
         puts"@@@@@inside@@@#{@post}"
         puts"@@@@@POSTS@@@#{@posts}"
      end
    end 
    return @posts
    puts"@@@@@RETURN@@@@#{@posts}" 
  end
  

end
