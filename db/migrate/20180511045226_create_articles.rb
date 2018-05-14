class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.string :description
      t.boolean :favorited, default: false
      t.integer :favorites_count, default: 0

      t.timestamps null: false
    end
  end
end
