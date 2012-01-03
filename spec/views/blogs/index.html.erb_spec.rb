require 'spec_helper'

describe "blogs/index.html.erb" do
  before(:each) do
    assign(:blogs, [
      stub_model(Blog,
        :blogger_name => "Blogger Name",
        :blog_url => "Blog Url"
      ),
      stub_model(Blog,
        :blogger_name => "Blogger Name",
        :blog_url => "Blog Url"
      )
    ])
  end

  it "renders a list of blogs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Blogger Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Blog Url".to_s, :count => 2
  end
end
