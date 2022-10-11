class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :initiated_friendships, foreign_key: :user_id, class_name: "Friendship", dependent: :destroy
  has_many :accepted_friendships, foreign_key: :friend_id, class_name: "Friendship", dependent: :destroy
  has_many :received_friend_requests, foreign_key: :receiver_id, class_name: "FriendRequest", dependent: :destroy
  has_many :sent_friend_requests, foreign_key: :sender_id, class_name: "FriendRequest", dependent: :destroy
  has_many :initiated_friends, through: :initiated_friendships, source: :friend, dependent: :destroy
  has_many :accepted_friends, through: :accepted_friendships, source: :user, dependent: :destroy
  has_many :comments, foreign_key: :commenter_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :profile, dependent: :destroy

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  after_create :send_welcome_email

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

  def random_strangers
    5.times.map { User.all.sample }.uniq
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_later
  end
end
