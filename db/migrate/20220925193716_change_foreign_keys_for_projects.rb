class ChangeForeignKeysForProjects < ActiveRecord::Migration[7.0]
  def change
    rename_column :friend_requests, :request_receiver_id, :receiver_id
    rename_column :friend_requests, :request_sender_id, :sender_id
  end
end
