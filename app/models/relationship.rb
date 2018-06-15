class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: User.name

  enum status: [:requested, :accepted] #:deleted, :blocked
end
