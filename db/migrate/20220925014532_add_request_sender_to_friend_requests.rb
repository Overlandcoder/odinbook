class AddRequestSenderToFriendRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :friend_requests, :request_sender, index: true,
                  foreign_key: { to_table: :users }
  end
end
