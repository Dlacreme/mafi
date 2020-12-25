class AccountController < ApplicationController
  before_action :require_login

  def index
    data Account.where("user_id = '#{@current_user.id}' AND disabled_at IS NULL")
  end

  def show
    data Account.where("id = '#{params[:id]}' AND user_id = '#{@current_user.id}'").first
  end

  def create
    return save_form AccountForm.new(Account.new), param_create
  end

  def update
    account = Account.find(params[:id])
    return not_found if account.user_id != @current_user.id
    return save_form AccountForm.new(Account.find(params[:id])), param_update
  end

  def destroy
    account = Account.find(params[:id])
    return not_found if account.user_id != @current_user.id
    account.disabled_at = DateTime.now
    account.save
    return ok
  end

private

  def param_create
    ps = params.require(:account).permit(:title)
    ps[:user_id] = @current_user.id
    return ps
  end

  def param_update
    params.require(:account).permit(:title)
  end

end
