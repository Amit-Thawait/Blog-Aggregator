class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.string :title
      t.text :content
      t.string :author
      t.datetime :post_date
      t.references :blog

      t.timestamps
    end
  end
end
