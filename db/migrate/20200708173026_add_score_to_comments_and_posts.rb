class AddScoreToCommentsAndPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :score, :integer, default: 0
    add_column :comments, :score, :integer, default: 0
  end
end
