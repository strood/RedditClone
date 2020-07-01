class CreateSubs < ActiveRecord::Migration[6.0]
  def change
    create_table :subs do |t|
      t.string :title, null: false, unique: true
      t.text :description, null: false
      t.integer :moderator, null: false

      t.timestamps
    end

    add_index :subs, :title

  end
end
