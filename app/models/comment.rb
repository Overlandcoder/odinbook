class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  belongs_to :post

  validates :body, presence: true, length: { minimum: 1 }
end
