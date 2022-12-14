class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true, length: { in: 1..500 }

  scope :ordered, -> { order(id: :desc) }

  def created_time_formatted
    created_at.strftime("%b %-d, %Y - %l:%M %P")
  end

  def liked_by?(user)
    likes.any? { |like| like.user == user }
  end

  def find_like(user)
    likes.find_by(user: user)
  end
end
