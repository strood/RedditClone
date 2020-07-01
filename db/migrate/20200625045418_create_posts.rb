class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.integer :sub, null: false
      t.integer :author, null: false

      t.timestamps
    end

    add_index :posts, :title
    add_index :posts, :sub
    add_index :posts, :author
    
  end
end
