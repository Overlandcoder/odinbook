class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :friend_requests_received, foreign_key: :receiver_id, class_name: "FriendRequest"
  has_many :friend_requests_sent, foreign_key: :sender_id, class_name: "FriendRequest"


  validates :email, uniqueness: true
  validates :username, uniqueness: true

  def created_time_formatted
    created_at.strftime("%b %-d, %Y")
  end

  def friend?(user)
    friends.include?(user)
  end
end
