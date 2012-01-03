require 'spec_helper'

describe "blogs/edit.html.erb" do
  before(:each) do
    @blog = assign(:blog, stub_model(Blog,
      :blogger_name => "MyString",
      :blog_url => "MyString"
    ))
  end

  it "renders the edit blog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blogs_path(@blog), :method => "post" do
      assert_select "input#blog_blogger_name", :name => "blog[blogger_name]"
      assert_select "input#blog_blog_url", :name => "blog[blog_url]"
    end
  end
end
