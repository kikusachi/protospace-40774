class ApplicationController < ActionController::Base
  before_action :users_infomation_save, if: :devise_controller?

  private
  def users_infomation_save
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:profile,:occupation,:position])
  end
end
