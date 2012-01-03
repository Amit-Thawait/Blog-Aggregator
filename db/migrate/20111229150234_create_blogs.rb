class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :blogger_name
      t.string :blog_url

      t.timestamps
    end
  end
end
