class Relationship < ApplicationRecord
  after_create_commit :notify

  belongs_to :requesting, class_name: User.name
  belongs_to :requested, class_name: User.name

  validates :requesting_id, presence: true
  validates :requested_id, presence: true
  validates :status, presence: true

  validate :deny_self_referential_friendship

  enum status: [:requested, :accepted]

  private
  def deny_self_referential_friendship
    errors.add(:requested_id, (I18n.t "models.relationships.deny_self_referential_friendship.can_not_add_self")) if requesting_id == requested_id
  end

  def notify
    Notification.create user: requested, src: requesting, message: construct_message
  end

  def construct_message
    requesting.name + " " + I18n.t("models.relationships.send_request.send_friend_request")
  end
end
