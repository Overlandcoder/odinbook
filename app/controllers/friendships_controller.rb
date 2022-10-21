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
    return unless @friendship.save

    FriendRequestDestroyer.call(friendship_params)
    redirect_to request.referrer
  end

  def destroy
    @friendship = Friendship.find_by(user_id: friendship_params[:user_id],
                                     friend_id: friendship_params[:friend_id]) ||
                  Friendship.find_by(user_id: friendship_params[:friend_id],
                                     friend_id: friendship_params[:user_id])
    return unless @friendship.destroy

    redirect_to request.referrer
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
