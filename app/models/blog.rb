class Blog < ActiveRecord::Base
  validates_presence_of :blogger_name
  validates_presence_of :blog_url
  
  def self.get_all_blog_objects
    Blog.find(:all)
  end
  
end
