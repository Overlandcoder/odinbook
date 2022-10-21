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
      FriendRequestDestroyer.call(friendship_params)

      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship = Friendship.find_by(user_id: friendship_params[:user_id],
                                     friend_id: friendship_params[:friend_id]) ||
                  Friendship.find_by(user_id: friendship_params[:friend_id],
                                     friend_id: friendship_params[:user_id])
    @friendship.destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
