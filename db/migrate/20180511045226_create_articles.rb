class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.string :description
      t.boolean :favorited, default: false
      t.integer :favorites_count

      t.timestamps null: false
    end
  end
end
