class AddIndexToCommentsAndPostsScore < ActiveRecord::Migration[6.0]
  def change
    add_index :posts, :score
    add_index :comments, :score
  end
end
