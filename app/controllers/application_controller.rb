class ApplicationController < ActionController::Base
  include LoginHelper
  include CanCan::ControllerAdditions

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    log_out
    redirect_to :root, :alert => exception.message + " You have been logged out."
  end

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
end
