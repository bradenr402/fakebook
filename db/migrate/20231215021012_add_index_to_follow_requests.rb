class AddIndexToFollowRequests < ActiveRecord::Migration[7.1]
  def change
    add_index :follow_requests, [:follower_id, :followee_id], unique: true
  end
end
