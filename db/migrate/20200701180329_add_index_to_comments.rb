class AddIndexToComments < ActiveRecord::Migration[6.0]
  def change
    add_index :comments, :parent_comment_id
  end
end
