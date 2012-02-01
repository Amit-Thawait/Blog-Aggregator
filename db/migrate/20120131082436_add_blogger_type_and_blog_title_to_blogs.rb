class AddBloggerTypeAndBlogTitleToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :blogger_type, :string
    add_column :blogs, :blog_title, :string
  end
end
