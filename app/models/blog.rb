class Blog < ActiveRecord::Base
  require 'open-uri'
  validates_presence_of :blogger_name
  validates_presence_of :blog_url
  validates_format_of :blog_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_uniqueness_of :blog_url
  #Associations goes here
  has_many :posts
  
  #This method will read the posts of the blogs and stores it in DB. Currently we are showing the posts directly from the DB.
  def read_posts(blog)
    @doc = Nokogiri::HTML(open("#{blog.blog_url}"))
      if !@doc.nil?
        @doc.css('div.post').each do |node|
          @post = Post.new
          title_url = node.css('h3.post-title a')
          @post.blog_id = blog.id
          blog.blog_title = @doc.css('h1.title').text
          blog.save!
          @post.url = title_url[0]['href']
          @post.title = node.css('h3.post-title').text          
          @post.content = node.css('div.post-body').inner_html.chomp
          @post.author = node.css('span.fn').text          
          published_date = node.css('abbr.published') 
          @post.post_date = Time.parse(published_date[0]['title'].gsub('T'," "))          
          @post.save!
        end         
      end
  end
  
  #This method is used to read posts from pat's blogs
  #We know that separate method for each blog is not a good idea. It's quite difficult to write a generic method since everyone is following different styles for their blogs.
  #Anyway we are trying to figure it out...
  def read_posts_one(blog)
     @doc = Nokogiri::HTML(open("#{blog.blog_url}"))
       if !@doc.nil?
         author_name = @doc.css('title').text
         @doc.css('article.post').each do |node|
           @post = Post.new
           title_url = node.css('h1 a')           
           @post.blog_id = blog.id
           blog.blog_title = "#{author_name}'s blogs"
           blog.save!
           append_url = "http://patshaughnessy.net"
           @post.url = append_url + title_url[0]['href']
           @post.title = node.css('h1').text    
           #content_data = node.css('section.content').inner_html.chomp
           #@post.content = content_data.css('p a').last.attr('href')   
           #links = "http://patshaughnessy.net/" + node.css('section.content').css('a').map{ |link| link['href']}.last           
           content_orig = node.css('section.content').inner_html.chomp
           @post.content = full_content(content_orig,append_url,full_string_content="")     
           @post.author = author_name
           @post.post_date = node.css('span.date').text.to_date
           @post.save!
         end         
       end
  end
  
  #This method is used to read posts from Alex's blogs
   def read_posts_two(blog)
     @doc = Nokogiri::HTML(open("#{blog.blog_url}"))
       if !@doc.nil?   
         author_name = @doc.css('div#header h1').text
         @doc.css('div.post').each do |node|
         @post = Post.new
         title_url = node.css('div.title a')
         @post.blog_id = blog.id
         blog.blog_title = "#{author_name}'s blogs"
         blog.save!
         @post.title = node.css('div.title').text
         @post.post_date = node.css('div.date').text.to_date
         @post.url = "http://www.alexrothenberg.com/" + title_url[0]['href']
         @post.content  = node.css('div.extract').inner_html.chomp         
         @post.author = author_name        
         @post.save!
         end         
       end
  end  

 private
  # This method is used to append the default pat's url to the link which it is missed
  def full_content(content,link,full_string_content="")
    c = content.partition('a href')
    full_string_content << c[0] << c[1]
    if !c[2].empty?
      if c[2].include?('http')
        full_string_content << full_content(c[2],link)
      else
        d = c[2].partition('/')
        g = d[2].partition('>')
        full_string_content << d[0].to_s << link+d[1].to_s + g[0] + " target='_blank'" + g[1] +g[2]
      end
    end
    full_string_content
  end  

end
