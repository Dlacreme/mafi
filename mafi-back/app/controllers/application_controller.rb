# typed: false
class ApplicationController < ActionController::API
  before_action :logged_in?

  protected

  ## RENDER
  # render_json return data with appropriate code
  def render_json(code = 200, message = "OK", data = nil, errors = nil)
    res = {}
    res[:message] = message
    res[:errors] = errors if errors != nil
    res[:data] = data if data != nil
    render :json => res, :status => code
  end

  # unvalid trigger an 400 with a generic error for invalid query
  def unvalid(message = "Unvalid query", errors = nil, data = nil)
    render_json(400, message, data, errors)
  end

  # save_form process the form and return a valid response
  def save_form(form, params)
    return render_json 400, "Invalid query", nil, form.errors.full_messages unless form.validate(params)
    return render_json 500, "Oops. Server issue", nil, form.errors.full_messages if form.save != true
    return render_json 500, "Oops. Cannot preload data", nil, form.errors.full_messages unless form.prepopulate!
    render_json 200, "OK", form.model
  end

  # data return raw data as json
  def data(data = nil)
    return json_json 404, "Nothing found", nil, nil if data == nil
    render_json 200, "OK", data
  end

  # oops should be called when an unexpected error happened
  def oops()
    return render_json 500, "Oops. Server Issue"
  end

  # ok return an 200 status with no message nor data
  def ok
    return render_json 200, "OK"
  end

  # not_found returns a 404 with a generic 'not found' error. @object_name? is the resource's name
  def not_found(object_name = nil)
    return render_json 404, nil, object_name != nil ? ("#{object_name} was not found") : ("Not Found")
  end

  # not_implemented returns a standard 501 error code. Can be used as a placeholder while working on an endpoint
  def not_implemented
    return render_json 501, "Endpoint is not ready"
  end

  ## HELPERS

  # process_form process a form if it's valid and return an appropriate HTTP code. !! It does not render
  def process_form(form, params)
    return 400 unless form.validate(params)
    return 500 if form.save != true || ! form.prepopulate!
    200
  end

  ## Authentication

  def logged_in?
    parse_jwt
  end

  def require_login
    render_json(401, "Unauthorized") if @current_user == nil
  end

  def require_admin
    render_json(401, "Unauthorized") unless logged_in? && @current_user.admin?
  end

  # @roles = []Roles
  def require_access(roles)
    return false if @current_user == nil
    return roles.include?(@current_user.role_id)
  end

  def parse_jwt
    return unless request.headers['Authorization'].present?
    @jwt ||= JsonWebToken.decode(request.headers['Authorization'].delete_prefix('Bearer '))
    @current_user ||= User.find(@jwt[:user_id]) if @jwt && @jwt[:user_id]
  end


end
