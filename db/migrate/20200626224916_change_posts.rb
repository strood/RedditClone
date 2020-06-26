class ChangePosts < ActiveRecord::Migration[6.0]
  def change
    remove_index :posts, :sub
    remove_column :posts, :sub
    remove_index :posts, :title
  end
end
