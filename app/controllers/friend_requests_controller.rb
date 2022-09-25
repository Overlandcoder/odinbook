class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.all
  end

  def new
    @friend_request = FriendRequest.new
  end

  def create
    @user = User.find(friend_request_params[:request_receiver_id])
    @friend_request = @user.friend_requests.build(friend_request_params)

    if @friend_request.save
      flash.now[:success] = "Friend request sent."
    else
      flash.now[:error] = "Unable to send friend request."
    end
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:request_sender_id, :request_receiver_id)
  end
end
