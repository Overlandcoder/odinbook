class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments

  validates :title, presence: true, length: { in: 5..100 }
  validates :body, presence: true, length: { in: 1..500 }

  def created_time_formatted
    created_at.strftime("%b %-d, %Y - %l:%M %P")
  end
end
