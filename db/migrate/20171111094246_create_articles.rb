class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.text :content
      t.string :author
      t.datetime :published
      t.integer :feed_id

      t.timestamps
    end
  end
end
