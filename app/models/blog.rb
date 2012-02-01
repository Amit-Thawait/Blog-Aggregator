class Blog < ActiveRecord::Base
  require 'open-uri'
  validates_presence_of :blogger_name
  validates_presence_of :blog_url
  validates_format_of :blog_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
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
  

end
