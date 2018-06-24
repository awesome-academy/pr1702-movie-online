class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :film
  scope :sort_comments, ->{order ("created_at DESC")}
end
