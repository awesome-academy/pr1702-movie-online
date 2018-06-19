class User < ApplicationRecord
  devise :database_authenticatable, :confirmable,:registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers:%i[facebook]

  ratyrate_rater

  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :favourites, dependent: :destroy

  has_many :watched_films, through: :histories, source: :film
  has_many :favourite_films, through: :histories, source: :film

  scope :created_sort, ->{order created: :desc}
  enum role: [:normal, :admin]

  has_many :active_relationships, class_name: Relationship.name, foreign_key: :requesting_id
  has_many :requesting_friends, -> {where(relationships: {status: 0})} ,through: :active_relationships, source: :requested
  has_many :accepting_friends, -> {where(relationships: {status: 1})}, through: :active_relationships, source: :requested

  has_many :passive_relationships, class_name: Relationship.name, foreign_key: :requested_id
  has_many :requested_friends, -> {where(relationships: {status: 0})}, through: :passive_relationships, source: :requesting
  has_many :accepted_friends, -> {where(relationships: {status: 1})}, through: :passive_relationships, source: :requesting

  def friends
    (accepted_friends + accepting_friends).uniq
  end

  def request_friend_with other
    active_relationships.create(requested: other, status: :requested) if (other.present?) &&
                            (!involved_with? other)
  end

  def accept_friend_with other
    passive_relationships.find_by(requesting_id: other.id).update(status: :accepted) if (
      (other.present?) && (check_relationship_status_with(other, :requested)))
  end

  def delete_request other, relation, type
    case type.to_s
    when "requested"
      requested_friends.delete(other) if ((other.present?) && (relation.present?) &&
       (relation.requesting == other) && (relation.requested == self))
    when "requesting"
      requesting_friends.delete(other) if ((other.present?) && (relation.present?) &&
       (relation.requesting == self) && (relation.requested == other))
    end
  end

  def unfriend other
    return unless other
    rela = active_relationships.find_by(requested: other) || passive_relationships.find_by(requesting: other)
    return unless rela
    rela.destroy if is_friend_with?(other)
  end

  def get_relationship other, type, key
    rela = send(type.to_s + "_relationships")
    if key.to_s == "requesting_id"
      rela.find_by(requesting: other)
    else
      rela.find_by(requested: other)
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.confirmed_at = Time.now
      user.confirmation_token = nil
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private
  def is_friend_with? other
    friends.include? other
  end

  def involved_with? other
    active_rel_with_other = active_relationships.find_by requested_id: other.id
    passsive_rel_with_other = passive_relationships.find_by requesting_id: other.id
    active_rel_with_other.present? || passsive_rel_with_other.present?
  end

  def check_relationship_status_with other, status
    list_of_friends_with_status = self.send(status.to_s + "_friends")
    list_of_friends_with_status.include? other
  end
end
