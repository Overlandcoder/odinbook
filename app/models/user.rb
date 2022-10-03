class User < ApplicationRecord
  include Gravtastic
  gravtastic
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

  def friends
    initiated_friends + accepted_friends
  end

  def friend?(other_user)
    friends.include?(other_user)
  end

  def can_send_request_to?(other_user)
    !friend?(other_user) && self != other_user &&
      !sent_request_to?(other_user) && !received_request_from?(other_user)
  end

  def sent_request_to?(other_user)
    sent_friend_requests.any? { |request| request.receiver == other_user }
  end

  def received_request_from?(other_user)
    received_friend_requests.any? { |request| request.sender == other_user }
  end
end
