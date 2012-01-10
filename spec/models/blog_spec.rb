require 'spec_helper'
require 'Blog'
describe Blog do 
  
  before(:each) do
    @blog = Blog.new  
  end
  
  after(:each) do
    @blog.blogger_name.should_not eql('')
    @blog.should be_valid_url(@blog.blog_url)
  end
    
  it 'blogger name should not be blank' do
    @blog.blogger_name = "lakshmi"     
  end 
  
  it 'blog url should not be blank' do   
    @blog.blog_url = "http://lakshmi-ks.blogspot.com"    
  end   
 
end
