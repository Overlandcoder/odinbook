class Comment < ApplicationRecord
  belongs_to :author, class: "User"
end
