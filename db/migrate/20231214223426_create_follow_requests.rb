class CreateFollowRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :follow_requests do |t|
      t.integer :follower_id
      t.integer :followee_id
      t.integer :status, default: 0


      t.timestamps
    end
    add_index :follow_requests, :follower_id
    add_index :follow_requests, :followee_id
    add_index :follow_requests, :status
  end
end
