class FriendRequestDestroyer < ApplicationService
  attr_reader :sender_id, :receiver_id

  def initialize(params)
    @sender_id = params[:user_id]
    @receiver_id = params[:friend_id]
  end

  def call
    FriendRequest.find_by(sender_id: sender_id, receiver_id: receiver_id).delete
  end
end
