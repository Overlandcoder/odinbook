class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.all
  end

  def new
    @friend_request = FriendRequest.new
  end

  def create
    @friend_request = current_user.friend_requests_sent.build(friend_request_params)

    if @friend_request.save
      flash.now[:success] = "Friend request sent."
    else
      flash.now[:error] = "Unable to send friend request."
    end
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id)
  end
end
