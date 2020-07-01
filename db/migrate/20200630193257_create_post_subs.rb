class CreatePostSubs < ActiveRecord::Migration[6.0]
  def change
    create_table :post_subs do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end
    # This line below adds a db constraint on the pairing, so no duplicate post_subs
    add_index :post_subs, [:post_id, :sub_id], unique: true
  end
end
