class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.all
  end

  def new
    @friend_request = FriendRequest.new
  end

  def create
    @friend_request = current_user.sent_friend_requests.build(friend_request_params)

    if @friend_request.save
      flash.now[:success] = "Friend request sent."
    else
      flash.now[:error] = "Unable to send friend request."
    end
  end

  def destroy
    @friend_request = FriendRequest.find_by(friend_request_params)
    @friend_request.destroy
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id)
  end
end
