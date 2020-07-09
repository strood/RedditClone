class AddSlugs < ActiveRecord::Migration[6.0]
  def change
    add_column :subs, :slug, :string
    add_column :posts, :slug, :string
    add_column :comments, :slug, :string
  end

end
