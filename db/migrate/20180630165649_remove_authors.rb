class RemoveAuthors < ActiveRecord::Migration
  def change
    remove_foreign_key :articles, :author
    remove_index :articles, :author_id
    drop_table :authors
  end
end
