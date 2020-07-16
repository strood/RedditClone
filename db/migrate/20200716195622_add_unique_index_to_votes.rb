class AddUniqueIndexToVotes < ActiveRecord::Migration[6.0]
  def change
    remove_index :votes, [:votable_type, :votable_id]
    add_index :votes, [:user_id, :votable_id, :votable_type], unique: true
  end
end
