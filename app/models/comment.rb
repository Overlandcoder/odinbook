class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  belongs_to :post

  validates :body, presence: true, length: { minimum: 1 }

  def created_time_formatted
    created_at.strftime("%b %-d, %Y - %l:%M %P")
  end
end
