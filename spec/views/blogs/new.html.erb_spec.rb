require 'spec_helper'

describe "blogs/new.html.erb" do
  before(:each) do
    assign(:blog, stub_model(Blog,
      :blogger_name => "MyString",
      :blog_url => "MyString"
    ).as_new_record)
  end

  it "renders new blog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blogs_path, :method => "post" do
      assert_select "input#blog_blogger_name", :name => "blog[blogger_name]"
      assert_select "input#blog_blog_url", :name => "blog[blog_url]"
    end
  end
end
