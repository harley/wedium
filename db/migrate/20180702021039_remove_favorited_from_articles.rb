class RemoveFavoritedFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :favorited, :boolean, default: false
  end
end
