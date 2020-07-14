class CreateUserSubs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_subs do |t|
      t.integer :user_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end
    # This line below adds a db constraint on the pairing, so no duplicate user_subs
    add_index :user_subs, [:user_id, :sub_id], unique: true
  end
end
