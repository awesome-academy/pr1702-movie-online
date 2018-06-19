class RelationshipsController < ApplicationController
  def index
    @my_friends = current_user.friends.paginate(page: params[:page], per_page: 10)
  end

  def create
    requested_user = User.find_by id: params[:requested_id]
    if current_user.request_friend_with requested_user
      flash[:success] = I18n.t "controllers.relationships.create.request_success"
    else
      flash[:danger] = I18n.t "controllers.relationships.create.request_failure"
    end
    redirect_back fallback_location: root_path
  end

  def update
    requesting_user = User.find_by id: params[:requesting_id]
    if current_user.accept_friend_with requesting_user
      flash[:success] = I18n.t "controllers.relationships.update.accept_success"
    else
      flash[:danger] = I18n.t "controllers.relationships.update.accept_failure"
    end
    redirect_back fallback_location: root_path
  end

  def requesting_friends
    @requesting_friends = current_user.requesting_friends.paginate(page: params[:page], per_page: 10)
  end

  def requested_friends
    @requested_friends = current_user.requested_friends.paginate(page: params[:page], per_page: 10)
  end

  def unfriend
    friend = User.find_by id: params[:friend_id]
    if current_user.unfriend friend
      flash[:success] = I18n.t "controllers.relationships.unfriend.unfriend_success"
    else
      flash[:danger] = I18n.t "controllers.relationships.unfriend.unfriend_success"
    end
    redirect_back fallback_location: root_path
  end

  def cancel_request_with
    relationship = Relationship.find_by id: params[:id]
    requested_user = User.find_by id: params[:requested_user]
    if current_user.delete_request requested_user, relationship, :requesting
      flash[:success] = I18n.t "controllers.relationships.cancel_request_with.cancel_success"
    else
      flash[:danger] = I18n.t "controllers.relationships.cancel_request_with.cancel_failure"
    end
    redirect_back fallback_location: root_path
  end

  def delete_request_from
    relationship = Relationship.find_by id: params[:id]
    requesting_user = User.find_by id: params[:requesting_user]
    if current_user.delete_request requesting_user, relationship, :requested
      flash[:success] = I18n.t "controllers.relationships.delete_request_from.delete_success"
    else
      flash[:success] = I18n.t "controllers.relationships.delete_request_from.delete_failure"
    end
    redirect_back fallback_location: root_path
  end
end
