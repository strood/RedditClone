class ChangeSub < ActiveRecord::Migration[6.0]
  def change
    remove_column :subs, :moderator
    add_column :subs, :user_id, :integer, null: false
  end
end
