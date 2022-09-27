class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
    @user = User.find(params[:user_id])
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.accepted_friendships.build(friendship_params)

    if @friendship.save!
      friend_request_destroyer = FriendRequestDestroyer.new(friendship_params)
      friend_request_destroyer.destroy_friend_request
      # flash[:success]
    else
      render :new, status: :unprocessable_entity
      # flash
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
