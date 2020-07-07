class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.integer :user_id, null: false
      t.references :votable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
