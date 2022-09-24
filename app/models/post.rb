class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  validates :title, presence: true, length: { in: 5..100 }
  validates :body, presence: true, length: { in: 1..500 }
end
