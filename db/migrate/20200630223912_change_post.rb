class ChangePost < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :author
    add_column :posts, :user_id, :integer, null: false
  end
end
