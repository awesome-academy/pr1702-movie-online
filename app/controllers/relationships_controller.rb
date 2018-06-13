class RelationshipsController < ApplicationController
  def index
    @my_friends = current_user.friends.paginate(page: params[:page], per_page: 10)
  end

  def create
    requested_user = User.find_by id: params[:requested_id]
    current_user.request_friend_with(requested_user) if (requested_user.present?) &&
                            (!current_user.involved_with? requested_user)
    redirect_back(fallback_location: root_path)
  end

  def update
    requesting_user = User.find_by id: params[:requesting_id]
    current_user.accept_friend_with(requesting_user) if ((requesting_user.present?) &&
                   (current_user.check_relationship_status_with(requesting_user, :requested)))
    redirect_back(fallback_location: root_path)
  end

  def requesting_friends
    @requesting_friends = current_user.requesting_friends.paginate(page: params[:page], per_page: 10)
  end

  def requested_friends
    @requested_friends = current_user.requested_friends.paginate(page: params[:page], per_page: 10)
  end

  def unfriend
    friend = User.find_by id: params[:friend_id]
    rel = (current_user.active_relationships.find_by(requested_id: params[:friend_id]) ||
        current_user.passive_relationships.find_by(requesting_id: params[:friend_id]))
    rel.destroy if ((rel.present?) && (friend.present?) && (current_user.is_friend_with?(friend)))
    redirect_back(fallback_location: root_path)
  end

  def cancel_request_with
    rel = Relationship.find_by id: params[:id]
    requested_user = User.find_by id: rel.requested_id if rel.present?
    rel.destroy if ((rel.present?) && (requested_user.present?) &&
      (current_user.check_relationship_status_with(requested_user, :requesting)))
    redirect_back(fallback_location: root_path)
  end

  def delete_request_from
    rel = Relationship.find_by id: params[:id]
    requesting_user = User.find_by(id: rel.requesting_id) if rel.present?
    rel.destroy if ((rel.present?) && (requesting_user.present?) &&
      (current_user.check_relationship_status_with(requesting_user, :requested)))
    redirect_back(fallback_location: root_path)
  end
end
