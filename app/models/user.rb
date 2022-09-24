class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  def created_time_formatted
    created_at.strftime("%b %-d, %Y")
  end
end
