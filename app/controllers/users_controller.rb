class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
    @relationship = Relationship.new
  end

  def show
    @user = User.find_by id: params[:id]
    redirect_to users_path unless @user
  end
end
