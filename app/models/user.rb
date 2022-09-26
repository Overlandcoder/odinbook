class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id
  has_many :initiated_friendships, foreign_key: :user_id, class_name: "Friendship"
  has_many :accepted_friendships, foreign_key: :friend_id, class_name: "Friendship"
  # rename to received_friend_requests and sent_friend_requests
  has_many :friend_requests_received, foreign_key: :receiver_id, class_name: "FriendRequest"
  has_many :friend_requests_sent, foreign_key: :sender_id, class_name: "FriendRequest"


  validates :email, uniqueness: true
  validates :username, uniqueness: true

  def created_time_formatted
    created_at.strftime("%b %-d, %Y")
  end

  # method needs revision
  def friend?(user)
    friends.include?(user)
  end

  def friends
    initiated_friendships + accepted_friendships
  end

  def user_friends
    User.where()
  end
end
