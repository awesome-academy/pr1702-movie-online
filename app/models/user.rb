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
    active_relationships.create(requested_id: other.id, status: :requested)
  end

  def accept_friend_with other
    passive_relationships.find_by(requesting_id: other.id).update status: :accepted
  end

  def is_friend_with? other
    friends.include? other
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
end
