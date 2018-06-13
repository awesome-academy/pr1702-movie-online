class Relationship < ApplicationRecord
  belongs_to :requesting, class_name: User.name
  belongs_to :requested, class_name: User.name

  validates :requesting_id, presence: true
  validates :requested_id, presence: true
  validates :status, presence: true
  validate :disallow_self_referential_friendship

  enum status: [:requested, :accepted] #:deleted, :blocked

  private
  def disallow_self_referential_friendship
    if requested_id == requesting_id
      errors.add(:requested_id, 'cannot refer back to the author')
    end
  end
end
