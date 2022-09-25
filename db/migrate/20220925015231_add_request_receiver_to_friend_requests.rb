class AddRequestReceiverToFriendRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :friend_requests, :request_receiver,
                  foreign_key: { to_table: :users }
  end
end
