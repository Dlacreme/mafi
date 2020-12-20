class AuthController < ApplicationController

  def signin
    save_form SigninForm.new(User.new), param_signin
  end

  def login
    ps = param_login
    user = try_log(ps[:email], ps[:password])
    return render_json 401, "Fail to login" unless user
    data = user.to_j
    data[:token] = JsonWebToken.encode({user_id: user.id})
    render_json(200, "OK", data)
  end

private

  def try_log(email, password)
    user = User.try_auth(email, password)
    return false unless user != nil && user != false
    return user
  end

  def param_login
    params.require(:auth).permit(:email, :password)
  end

  def param_signin
    params.require(:auth).permit(:email, :password)
  end

end
