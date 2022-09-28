class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id
  has_many :initiated_friendships, foreign_key: :user_id, class_name: "Friendship"
  has_many :accepted_friendships, foreign_key: :friend_id, class_name: "Friendship"
  has_many :received_friend_requests, foreign_key: :receiver_id, class_name: "FriendRequest"
  has_many :sent_friend_requests, foreign_key: :sender_id, class_name: "FriendRequest"
  has_many :initiated_friends, through: :initiated_friendships, source: :friend
  has_many :accepted_friends, through: :accepted_friendships, source: :user
  has_many :comments, foreign_key: :commenter_id
  has_many :likes

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
    initiated_friends + accepted_friends
  end

  # def user_friends
    # User.where(friends.any? { |h| h[:user_id] == self.id || h[:friend_id] == self.id })
    # friends.friends.where(friends.any? { |h| h[:user_id] == self.id || h[:friend_id] == self.id })
    # maybe use User.all.where
  # end
end
