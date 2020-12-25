class UserController < ApplicationController
  before_action :logged_in?

  def index
    return not_found unless @current_user && @current_user.admin?
    data User.all
  end

  def search
    data User.where("username LIKE '%?%' or '%?%'", params[:query], params[:query])
  end

  def show
    id = params[:id]
    id = @current_user.id if params[:id] == "0"

    data load(id)
  end

  def me
    return unauthorized unless @current_user
    data load(@current_user.id)
  end

private

  def load(id)
    User.find(id).to_j
  end

end
