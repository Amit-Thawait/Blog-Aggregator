require 'spec_helper'

describe "blogs/show.html.erb" do
  before(:each) do
    @blog = assign(:blog, stub_model(Blog,
      :blogger_name => "Blogger Name",
      :blog_url => "Blog Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Blogger Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Blog Url/)
  end
end
