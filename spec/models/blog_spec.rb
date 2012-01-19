require 'spec_helper'
require 'open-uri'
# require 'Blog'
describe Blog do 
 
  it "should fetch all the blog objects" do
    blog1 = Factory(:blog,:blogger_name=>'Mansi Shah',:blog_url => 'http://mansishahlearnings.blogspot.com/')
    blog2 = Factory(:blog,:blogger_name=>'Lakshmi ks',:blog_url => 'http://abc.blogspot.com/')
    blog3 = Factory(:blog,:blogger_name=>'Amit Thawait',:blog_url => 'http://xyz.blogspot.com/')  
    
    Blog.get_all_blog_objects.length == 3
  end
  
  it "should be able to read a nokogiri object" do
    blog1 = Factory(:blog,:blogger_name=>'Amit Thawait',:blog_url => 'http://amit-thawait-first-blog.blogspot.com/')
    doc = Nokogiri::HTML(open("#{blog1.blog_url}"))
    doc.should be_instance_of(Nokogiri::HTML::Document)
    doc.css('div.post')[0].css('h3.post-title a').text.should eql('My Third Post')
    doc.css('div.post')[0].css('h3.post-title a')[0]['href'].should eql('http://amit-thawait-first-blog.blogspot.com/2012/01/my-third-post.html') 
    doc.css('div.post')[0].css('div.post-body').inner_html.chomp.should eql("\n<div dir=\"ltr\" style=\"text-align: left;\" trbidi=\"on\">I am writing the content for my third post.</div>\n<div style=\"clear: both;\"></div>")
    doc.css('div.post')[0].css('span.fn').text.strip.should eql('Amit Thawait')
    doc.css('h1.title').text.strip.should eql('My First Blog')
    doc.css('div.post')[0].css('abbr.published')[0]['title'].gsub('T'," ").should eql('2012-01-04 06:40:00-08:00')   
  end
 
end
