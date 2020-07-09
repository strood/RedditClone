class AddIndexToSlugs < ActiveRecord::Migration[6.0]
  def change
    add_index :subs, :slug
    add_index :posts, :slug
    add_index :comments, :slug
  end
end
