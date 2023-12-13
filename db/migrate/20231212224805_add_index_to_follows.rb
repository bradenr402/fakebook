class AddIndexToFollows < ActiveRecord::Migration[7.1]
  def change
    add_index :follows, :follower_id
    add_index :follows, :followee_id
    add_index :follows, [:follower_id, :followee_id], unique: true
  end
end
