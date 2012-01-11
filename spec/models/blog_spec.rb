require 'spec_helper'
# require 'Blog'
describe Blog do 
  
  # before(:each) do
    # @blog = Blog.new  
  # end
#   
  # after(:each) do
    # @blog.blogger_name.should_not eql('')
    # @blog.should be_valid_url(@blog.blog_url)
  # end
#     
  # it 'blogger name should not be blank' do
    # @blog.blogger_name = "lakshmi"     
  # end 
#   
  # it 'blog url should not be blank' do   
    # @blog.blog_url = "http://lakshmi-ks.blogspot.com"    
  # end   
 
  it "should fetch all the blog objects" do
  blog1 = Factory(:blog,:blogger_name=>'Mansi Shah',:blog_url => 'http://mansishahlearnings.blogspot.com/')
  blog2 = Factory(:blog,:blogger_name=>'Lakshmi ks',:blog_url => 'http://abc.blogspot.com/')
  blog3 = Factory(:blog,:blogger_name=>'Amit Thawait',:blog_url => 'http://xyz.blogspot.com/')  
  
  Blog.get_all_blog_objects.length == 3
  
  end
 
end
