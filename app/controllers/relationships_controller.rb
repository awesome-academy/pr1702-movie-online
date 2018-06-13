class RelationshipsController < ApplicationController
  def requesting_friends
    @requesting_friends = current_user.requesting_friends
  end

  def cancel_request_with
    rel = Relationship.find_by id: params[:id]
    requesting = params[:requesting_id]
    requested = params[:requested_id]
    byebug
    # em check dieu kien de xem ho co mo dev tool len sua cac hidden field k
    rel.destroy if ( (rel.present?) &&
      (current_user.id.to_s == params[:requesting_id]) &&
      (rel.requesting_id.to_s == requesting) &&
      (rel.requested_id.to_s == requested) )

    redirect_back(fallback_location: root_path)
  end

  def requested_friends
    @requested_friends = current_user.requested_friends
  end

  def delete_request_from
    rel = Relationship.find_by id: params[:id]
    requesting = params[:requesting_id]
    requested = params[:requested_id]
    byebug

    rel.destroy if ( (rel.present?) &&
      (current_user.id.to_s == params[:requested_id]) &&
      (rel.requesting_id.to_s == requesting) &&
      (rel.requested_id.to_s == requested) )

    redirect_back(fallback_location: root_path)
  end

  def accept_friend_with
    rel = Relationship.find_by id: params[:id]
    requesting = User.find_by id: params[:requesting_id]
    requested = User.find_by id: params[:requested_id]
    byebug
    requested_user.accept_friend_with(requesting_user) if  ( (rel.present?) &&
      (requesting_user.present?) && (requested_user.present?) &&
      (current_user.id == requested_user.id) &&
      (rel.requesting_id == requesting_user.id) &&
      (rel.requested_id == requested_user.id) )

    redirect_back(fallback_location: root_path)
  end

  def request_friend_with
    requested_user = User.find_by id: params[:requested_id]
    current_user.request_friend_with(requested_user) if requested_user.present?
    redirect_back(fallback_location: root_path)
  end
end
