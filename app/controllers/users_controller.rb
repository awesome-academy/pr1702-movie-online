class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find_by id: params[:id]
    redirect_to users_path unless @user
  end

end
