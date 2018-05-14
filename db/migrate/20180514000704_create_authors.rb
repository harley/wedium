class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :username
      t.string :bio
      t.string :image
      t.boolean :following, default: false

      t.timestamps null: false
    end
  end
end
