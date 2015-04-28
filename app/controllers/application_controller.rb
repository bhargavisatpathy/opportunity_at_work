class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if current_user && current_user.admin?
      admin_dashboard_index_path
    else
      root_path
    end
  end
end
